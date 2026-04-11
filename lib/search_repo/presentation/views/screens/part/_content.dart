part of '../repo_detail_screen.dart';

class _Content extends ConsumerWidget {
  const _Content({
    required this.item,
    required this.owner,
    required this.repo,
  });

  final Repo item;
  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(
      repoItemsProvider.select(
        (list) => list.items.firstWhere(
          (e) => e.owner.login == owner && e.name == repo,
        ),
      ),
    );

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
                  onPressed: useMockGithubApi
                      ? () {
                          ref.read(repoItemsProvider.notifier).updateItem(
                                owner,
                                repo,
                                Repo(
                                  owner: item.owner,
                                  id: item.id,
                                  name: item.name,
                                  stargazersCount: item.stargazersCount + 1,
                                  watchersCount: item.watchersCount,
                                  language: item.language,
                                  forksCount: item.forksCount,
                                  openIssuesCount: item.openIssuesCount,
                                ),
                              );
                        }
                      : null,
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
