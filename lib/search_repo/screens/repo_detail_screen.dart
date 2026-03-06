import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/search_repo/providers/repo_search_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RepoDetailScreen extends ConsumerWidget {
  const RepoDetailScreen({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(repoSearchNotifierProvider);
    final item = switch (state) {
      RepoSearchSuccess(:final data) =>
        data.items.firstWhere((e) => e.id == id),
      _ => null,
    };

    if (item == null) {
      return const Scaffold(
        body: Center(child: Text('リポジトリ情報が見つかりませんでした')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(item.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: item.owner.avatarUrl.isNotEmpty
                      ? NetworkImage(item.owner.avatarUrl)
                      : null,
                  child: item.owner.avatarUrl.isEmpty
                      ? const Icon(Icons.code, size: 28)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (item.language.isNotEmpty)
                        Row(
                          children: [
                            const Icon(Icons.code, size: 16),
                            const SizedBox(width: 4),
                            Text(item.language),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 16,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.star,
                  label: 'Stars',
                  value: item.stargazersCount,
                ),
                _InfoChip(
                  icon: Icons.remove_red_eye,
                  label: 'Watchers',
                  value: item.watchersCount,
                ),
                _InfoChip(
                  icon: Icons.call_split,
                  label: 'Forks',
                  value: item.forksCount,
                ),
                _InfoChip(
                  icon: Icons.error_outline,
                  label: 'Open issues',
                  value: item.openIssuesCount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 6),
            Text(
              '$label: $value',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
