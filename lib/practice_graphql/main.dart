import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// flutter run --dart-define=GITHUB_TOKEN=ghp_xxx...
const gitHubToken = String.fromEnvironment('GITHUB_TOKEN');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(const MyApp());
}

/// =============================
/// App
/// =============================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => AppProvider(
        child: MaterialApp(
          title: 'GitHub GraphQL Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const MyHomePage(appTitle: 'Repositories (GraphQL)'),
        ),
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({required String appTitle, super.key})
      : _appTitle = appTitle;
  final String _appTitle;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_appTitle)),
        body: const IssueListPage(),
      );
}

/// =============================
/// GraphQL Client (単一ファイル内)
/// =============================
final HttpLink _httpLink = HttpLink('https://api.github.com/graphql');
final AuthLink _authLink =
    AuthLink(getToken: () async => 'Bearer $gitHubToken');
final Link _link = _authLink.concat(_httpLink);

final GraphQLClient _client = GraphQLClient(
  cache: GraphQLCache(store: HiveStore()),
  link: _link,
);

class AppProvider extends StatelessWidget {
  const AppProvider({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) => GraphQLProvider(
        client: ValueNotifier<GraphQLClient>(_client),
        child: child,
      );
}

/// =============================
/// GraphQL Queries
/// =============================

// 動作確認用（任意）
const String basicQuery = '''
  query {
    viewer { login }
  }
''';

// リポジトリ一覧
const String repositoriesQuery = '''
  query {
    viewer {
      repositories(last: 10, orderBy: {field: UPDATED_AT, direction: DESC}, privacy: PUBLIC) {
        nodes {
          id
          name
          description
          url
          updatedAt
        }
      }
    }
  }
''';

/// =============================
/// Model & Fetcher
/// =============================
class Repository {
  Repository({
    required this.id,
    required this.name,
    required this.url,
    required this.updatedAt,
    this.description,
  });

  factory Repository.fromJson(Map<String, dynamic> json) => Repository(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        url: json['url'] as String,
        updatedAt: json['updatedAt'] as String,
      );

  final String id;
  final String name;
  final String? description;
  final String url;
  final String updatedAt;
}

Future<List<Repository>?> fetchRepositories() async {
  final response =
      await _client.query(QueryOptions(document: gql(repositoriesQuery)));

  if (response.hasException) {
    // 必要なら throw して上位で表示
    throw response.exception!;
  }

  final List<dynamic>? nodes =
      response.data?['viewer']?['repositories']?['nodes'];
  if (nodes == null) return null;

  return nodes
      .map((dynamic item) => Repository.fromJson(item as Map<String, dynamic>))
      .toList();
}

/// =============================
/// UI (List + Card)
/// =============================
class IssueListPage extends StatelessWidget {
  const IssueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenMissing = gitHubToken.isEmpty;

    return Column(
      children: [
        if (tokenMissing) const _TokenWarning(),
        Expanded(
          child: Center(
            child: FutureBuilder<List<Repository>?>(
              future: fetchRepositories(),
              builder: (
                BuildContext context,
                AsyncSnapshot<List<Repository>?> snapshot,
              ) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.active:
                  case ConnectionState.waiting:
                    return const Text('Loading');
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    final data = snapshot.data;
                    if (data == null || data.isEmpty) {
                      return const Text('No repositories');
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final repo = data[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CardItem(
                            id: repo.id,
                            title: repo.name,
                            message: repo.description ?? '',
                            url: repo.url,
                            updatedAt: repo.updatedAt,
                          ),
                        );
                      },
                    );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _TokenWarning extends StatelessWidget {
  const _TokenWarning();

  @override
  Widget build(BuildContext context) => MaterialBanner(
        content: const Text(
          'GITHUB_TOKEN が設定されていません。\n'
          'flutter run --dart-define=GITHUB_TOKEN=ghp_xxx で実行してください。',
        ),
        leading: const Icon(Icons.key),
        actions: [
          TextButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner(),
            child: const Text('Close'),
          ),
        ],
      );
}

class CardItem extends StatelessWidget {
  const CardItem({
    required this.title,
    required this.message,
    required this.url,
    required this.updatedAt,
    super.key,
    this.id,
  });

  final String? id;
  final String title;
  final String message;
  final String url;
  final String updatedAt;

  @override
  Widget build(BuildContext context) {
    // 指示通り、Directionality + Card + Column 構成
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        color: Colors.white, // = const Color(0xFFEFEFEF) ではなく白背景
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),
              Text(
                updatedAt,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
