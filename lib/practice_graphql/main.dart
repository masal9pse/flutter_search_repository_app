import 'package:flutter/material.dart';
// 追加：graphql_codegen が生成した型を取り込む
import 'package:flutter_engineer_codecheck/practice_graphql/repositories.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

/// 必須：GitHubトークン（少なくとも public_repo / private なら repo スコープ）
const gitHubToken = String.fromEnvironment('GITHUB_TOKEN');

/// 必須：Issueを作成/更新したい対象RepositoryのID（API Explorer等で取得）
const repositoryId = String.fromEnvironment('GITHUB_REPO_ID');

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
        appBar: AppBar(
          title: Text(_appTitle),
          actions: [
            // Issue追加の導線（空フォームで開く）
            IconButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const IssueInputPage()),
              ),
              icon: const Icon(Icons.add_circle_outline),
              tooltip: 'Create Issue',
            ),
          ],
        ),
        // ここはサンプルのまま（レポジトリ一覧UI）
        body: const IssueListPage(),
      );
}

/// =============================
/// GraphQL Client
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
/// （削除）文字列クエリ & 手書きモデル
/// =============================
// const String repositoriesQuery = ''' ... ''';  // ← 使わない
// class Repository { ... }                        // ← 使わない

/// =============================
/// Mutations（Issue 追加 / 更新）※そのまま
/// =============================

/// createIssue（repositoryId・title・body を投入）
const String createMutation = r'''
  mutation ($repoId: ID!, $titleText: String!, $bodyText: String!) {
    createIssue(input: {
      repositoryId: $repoId,
      title: $titleText,
      body: $bodyText
    }) {
      issue { id }
    }
  }
''';

/// updateIssue（id・title・body を更新）
const String updateMutation = r'''
  mutation ($idText: ID!, $titleText: String!, $bodyText: String!) {
    updateIssue(input: {
      id: $idText,
      title: $titleText,
      body: $bodyText
    }) {
      issue { id }
    }
  }
''';

/// =============================
/// Fetch（ここだけ型安全化）
/// =============================

Future<List<Query$Repositories$viewer$repositories$nodes?>?>
    fetchRepositories() async {
  final result = await _client.query(
    QueryOptions(
      document: documentNodeQueryRepositories,
      variables: Variables$Query$Repositories(last: 10).toJson(),
      fetchPolicy: FetchPolicy.cacheAndNetwork,
      parserFn: Query$Repositories.fromJson,
    ),
  );

  if (result.hasException) {
    throw result.exception!;
  }

  final data = result.parsedData; // ← 型付き (Query$Repositories)
  return data?.viewer.repositories.nodes; // List<...?>?
}

/// Issue作成（そのまま）
Future<void> createIssue({
  required BuildContext context,
  required String title,
  required String body,
}) async {
  if (repositoryId.isEmpty) {
    _toast(
      context,
      'GITHUB_REPO_ID が未設定です。--dart-define=GITHUB_REPO_ID=... を指定してください。',
    );
    return;
  }
  final options = MutationOptions(
    document: gql(createMutation),
    variables: <String, dynamic>{
      'repoId': repositoryId,
      'titleText': title,
      'bodyText': body,
    },
  );

  final result = await _client.mutate(options);
  if (result.hasException) {
    _toast(context, 'Create failed: ${result.exception}');
    return;
  }
  _toast(context, 'Issue created 🎉');
}

/// Issue更新（そのまま）
Future<void> updateIssue({
  required BuildContext context,
  required String id,
  required String title,
  required String body,
}) async {
  final options = MutationOptions(
    document: gql(updateMutation),
    variables: <String, dynamic>{
      'idText': id,
      'titleText': title,
      'bodyText': body,
    },
  );

  final result = await _client.mutate(options);
  if (result.hasException) {
    _toast(context, 'Update failed: ${result.exception}');
    return;
  }
  _toast(context, 'Issue updated ✅');
}

void _toast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

/// =============================
/// UI（FutureBuilderとListViewを生成型に合わせて変更）
/// =============================
class IssueListPage extends StatelessWidget {
  const IssueListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tokenMissing = gitHubToken.isEmpty;

    return Column(
      children: [
        if (tokenMissing) const _TokenWarning(),
        if (repositoryId.isEmpty) const _RepoIdWarning(),
        Expanded(
          child: Center(
            child: FutureBuilder<
                List<Query$Repositories$viewer$repositories$nodes?>?>(
              future: fetchRepositories(),
              builder: (
                BuildContext context,
                AsyncSnapshot<
                        List<Query$Repositories$viewer$repositories$nodes?>?>
                    snapshot,
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
                    final nodes = snapshot.data;
                    if (nodes == null || nodes.isEmpty) {
                      return const Text('No repositories');
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      itemCount: nodes.length,
                      itemBuilder: (context, index) {
                        final repo = nodes[index];
                        if (repo == null) return const SizedBox.shrink();
                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: CardItem(
                            title: repo.name,
                            message: repo.description ?? '',
                            url: repo.url,
                            // DateTime設定していない場合はString、設定している場合はDateTime
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

class _RepoIdWarning extends StatelessWidget {
  const _RepoIdWarning();

  @override
  Widget build(BuildContext context) => MaterialBanner(
        content: const Text(
          'GITHUB_REPO_ID が設定されていません。\n'
          'Issueの作成には対象リポジトリIDが必要です（API Explorer等で取得し、--dart-defineで渡してください）。',
        ),
        leading: const Icon(Icons.info_outline),
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

  final String? id; // 既存Issue編集時のみ使用
  final String title;
  final String message;
  final String url;
  final String updatedAt;

  @override
  Widget build(BuildContext context) {
    // Rowで本文 + 右端に編集ボタン
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Card(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
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
            IconButton(
              tooltip: 'Edit Issue',
              onPressed: () {
                // 既存Issue編集デモ：id/title/bodyを渡してフォームを開く
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => IssueInputPage(
                      id: id, // 既存IssueのIDがある時に渡す
                      title: title, // 仮にタイトルを初期値に
                      body: message, // 仮に本文を初期値に
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.create_outlined),
            ),
          ],
        ),
      ),
    );
  }
}

/// =============================
/// Issue 入力フォーム（Create/Update兼用）
/// =============================
class IssueInputPage extends StatefulWidget {
  const IssueInputPage({super.key, this.id, this.title, this.body});

  final String? id;
  final String? title;
  final String? body;

  @override
  State<IssueInputPage> createState() => _IssueInputState();
}

class _IssueInputState extends State<IssueInputPage> {
  late String titleInputText;
  late String bodyInputText;
  bool _isEnabled = false;

  @override
  void initState() {
    super.initState();
    titleInputText = widget.title ?? '';
    bodyInputText = widget.body ?? '';
    _changeEnabled();
  }

  void _changeEnabled() {
    _isEnabled = titleInputText.isNotEmpty && bodyInputText.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final isCreate = widget.id == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isCreate ? 'Issue Create' : 'Issue Update'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ColoredBox(
              color: const Color(0xFFEFEFEF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  // title
                  Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.only(left: 21, top: 10, bottom: 10),
                    child: const Text('title', style: TextStyle(fontSize: 16)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 21),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: '入力してください',
                        border: InputBorder.none,
                      ),
                      initialValue: widget.title ?? titleInputText,
                      onChanged: (v) {
                        titleInputText = v;
                        setState(_changeEnabled);
                      },
                    ),
                  ),
                  // body
                  Container(
                    color: Colors.white,
                    padding:
                        const EdgeInsets.only(left: 21, top: 10, bottom: 10),
                    child: const Text('body', style: TextStyle(fontSize: 16)),
                  ),
                  Container(
                    height: 120,
                    padding: const EdgeInsets.only(left: 21),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        hintText: '入力してください',
                        border: InputBorder.none,
                      ),
                      initialValue: widget.body ?? bodyInputText,
                      onChanged: (v) {
                        bodyInputText = v;
                        setState(_changeEnabled);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // submit
            Container(
              margin: const EdgeInsets.only(top: 21),
              color: Colors.white,
              child: ElevatedButton(
                onPressed: !_isEnabled
                    ? null
                    : () async {
                        if (isCreate) {
                          await createIssue(
                            context: context,
                            title: titleInputText,
                            body: bodyInputText,
                          );
                        } else {
                          await updateIssue(
                            context: context,
                            id: widget.id ?? '',
                            title: titleInputText,
                            body: bodyInputText,
                          );
                        }
                        if (context.mounted) Navigator.of(context).pop();
                      },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: Text(isCreate ? '保存' : '更新'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
