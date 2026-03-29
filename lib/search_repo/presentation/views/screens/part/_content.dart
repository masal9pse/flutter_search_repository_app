part of '../repo_detail_screen.dart';

class _Content extends ConsumerWidget {
  const _Content({
    required this.item,
    required this.owner,
    required this.repo,
  });

  final Item item;
  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ssot = ref.watch(repoItemsProvider);
    final ssotIndex = ssot.items.indexWhere(
      (e) => e.owner.login == owner && e.name == repo,
    );
    final displayItem =
        ssotIndex >= 0 ? ssot.items[ssotIndex] : item;

    return Scaffold(
      appBar: AppBar(
        title: Text(displayItem.name),
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
                  backgroundImage: displayItem.owner.avatarUrl.isNotEmpty
                      ? NetworkImage(displayItem.owner.avatarUrl)
                      : null,
                  child: displayItem.owner.avatarUrl.isEmpty
                      ? const Icon(Icons.code, size: 28)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        displayItem.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      if (displayItem.language.isNotEmpty)
                        Row(
                          children: [
                            const Icon(Icons.code, size: 16),
                            const SizedBox(width: 4),
                            Text(displayItem.language),
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
                  value: displayItem.stargazersCount,
                  onPressed: useMockGithubApi
                      ? () {
                          ref.read(repoItemsProvider.notifier).updateItem(
                                owner,
                                repo,
                                Item(
                                  owner: displayItem.owner,
                                  id: displayItem.id,
                                  name: displayItem.name,
                                  stargazersCount:
                                      displayItem.stargazersCount + 1,
                                  watchersCount: displayItem.watchersCount,
                                  language: displayItem.language,
                                  forksCount: displayItem.forksCount,
                                  openIssuesCount:
                                      displayItem.openIssuesCount,
                                ),
                              );
                        }
                      : null,
                ),
                _InfoChip(
                  icon: Icons.remove_red_eye,
                  label: 'Watchers',
                  value: displayItem.watchersCount,
                ),
                _InfoChip(
                  icon: Icons.call_split,
                  label: 'Forks',
                  value: displayItem.forksCount,
                ),
                _InfoChip(
                  icon: Icons.error_outline,
                  label: 'Open issues',
                  value: displayItem.openIssuesCount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
