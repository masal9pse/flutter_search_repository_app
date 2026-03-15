import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/search_repo/core/l10n/github_repo_api_exception_l10n.dart';
import 'package:flutter_engineer_codecheck/search_repo/providers/repo_search_provider.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RepoDetailScreen extends ConsumerWidget {
  const RepoDetailScreen({
    required this.owner,
    required this.repo,
    super.key,
  });

  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDetail =
        ref.watch(repoDetailProvider((owner: owner, repo: repo)));

    return asyncDetail.when(
      loading: () => _LoadingScaffold(owner: owner, repo: repo),
      data: (item) => _Content(item: item, owner: owner, repo: repo),
      error: (e, _) => _ErrorScaffold(
        owner: owner,
        repo: repo,
        exception: e as GithubRepoApiException,
      ),
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold({required this.owner, required this.repo});

  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$owner/$repo')),
      body: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _ErrorScaffold extends StatelessWidget {
  const _ErrorScaffold({
    required this.owner,
    required this.repo,
    required this.exception,
  });

  final String owner;
  final String repo;
  final GithubRepoApiException exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$owner/$repo')),
      body: Center(child: Text(exception.localizedMessage(context))),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    required this.item,
    required this.owner,
    required this.repo,
  });

  final Item item;
  final String owner;
  final String repo;

  @override
  Widget build(BuildContext context) {
    final displayItem = item;

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
