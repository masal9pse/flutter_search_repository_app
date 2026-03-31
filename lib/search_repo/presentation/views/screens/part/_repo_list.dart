part of '../repo_search_screen.dart';

class _RepoList extends StatelessWidget {
  const _RepoList({required this.data});

  final RepoList data;

  @override
  Widget build(BuildContext context) {
    final items = data.items;
    if (items.isEmpty) {
      return const Center(child: Text('検索結果がありません'));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => _RepoListItem(item: items[index]),
    );
  }
}
