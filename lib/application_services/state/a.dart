import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MaterialApp(home: GithubRepoSearchScreen()));
}

class GithubRepo {
  final int id;
  final String fullName;
  final String? description;
  final int stargazersCount;
  final DateTime updatedAt;

  GithubRepo({
    required this.id,
    required this.fullName,
    this.description,
    required this.stargazersCount,
    required this.updatedAt,
  });
}

class GithubRepoSearchScreen extends StatefulWidget {
  const GithubRepoSearchScreen({super.key});

  @override
  State<GithubRepoSearchScreen> createState() =>
      _GithubRepoSearchScreenState();
}

class _GithubRepoSearchScreenState extends State<GithubRepoSearchScreen> {
  final TextEditingController _controller = TextEditingController();

  late final List<GithubRepo> _mockData;

  @override
  void initState() {
    super.initState();
    _mockData = List.generate(
      100,
      (i) => GithubRepo(
        id: i,
        fullName: 'flutter/flutter_repo_$i',
        description: 'Description for repo $i',
        stargazersCount: 1000 + i * 10,
        updatedAt: DateTime.now().subtract(Duration(days: i)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchKeyword = _controller.text;
    final filtered = _mockData
        .where((repo) => repo.fullName.contains(searchKeyword))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Repo Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // if (searchKeyword.isEmpty)
          //   const Expanded(
          //     child: Center(child: Text('Enter a keyword to search.')),
          //   )
          // else if (filtered.isEmpty)
          //   const Expanded(
          //     child: Center(child: Text('No results found.')),
          //   )
          // else
            Expanded(
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (context, index) {
                  final repo = filtered[index];
                  final dateFmt = DateFormat.yMMMd();
                  final starFmt = NumberFormat.compact();

                  return ListTile(
                    title: Text(repo.fullName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (repo.description != null)
                          Text(repo.description!),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 14),
                            const SizedBox(width: 4),
                            Text('${starFmt.format(repo.stargazersCount)} stars'),
                            const SizedBox(width: 16),
                            Text('Updated: ${dateFmt.format(repo.updatedAt)}'),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Scaffold(
                            appBar: AppBar(title: Text(repo.fullName)),
                            body: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(repo.description ?? 'No description'),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
