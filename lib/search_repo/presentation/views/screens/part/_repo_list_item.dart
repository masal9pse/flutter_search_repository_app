part of '../repo_search_screen.dart';

class _RepoListItem extends StatelessWidget {
  const _RepoListItem({required this.item});

  final Repo item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: item.owner.avatarUrl.isNotEmpty
            ? NetworkImage(item.owner.avatarUrl)
            : null,
        child: item.owner.avatarUrl.isEmpty ? const Icon(Icons.code) : null,
      ),
      title: Text(
        item.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Row(
        children: [
          if (item.language.isNotEmpty) ...[
            Icon(
              Icons.code,
              size: 14,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(item.language),
            const SizedBox(width: 16),
          ],
          Icon(
            Icons.star,
            size: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text('${item.stargazersCount}'),
        ],
      ),
      isThreeLine: false,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RepoDetailScreen(
              owner: item.owner.login,
              repo: item.name,
            ),
          ),
        );
      },
    );
  }
}
