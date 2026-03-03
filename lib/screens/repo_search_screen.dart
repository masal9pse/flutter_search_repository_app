import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../search/search_repo_model.dart';
import '../providers/repo_search_provider.dart';

class RepoSearchScreen extends ConsumerWidget {
  const RepoSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(repoSearchNotifierProvider);
    final notifier = ref.read(repoSearchNotifierProvider.notifier);
    final controller = useTextEditingController(text: '');

    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub リポジトリ検索'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SearchForm(
            controller: controller,
            isLoading: searchState.isLoading,
            onSearch: () {
              final query = controller.text.trim().isEmpty ? 'Q' : controller.text;
              notifier.search(query);
            },
          ),
          const Divider(height: 1),
          Expanded(
            child: searchState.when(
              data: (data) => _RepoList(data: data),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => _ErrorView(
                message: err.toString(),
                onRetry: () => notifier.search(controller.text),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchForm extends StatelessWidget {
  const _SearchForm({
    required this.controller,
    required this.isLoading,
    required this.onSearch,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: '検索キーワード',
                hintText: '例: flutter',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              onFieldSubmitted: (_) => onSearch(),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: isLoading ? null : onSearch,
            icon: isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.search),
            label: const Text('検索'),
          ),
        ],
      ),
    );
  }
}

class _RepoList extends StatelessWidget {
  const _RepoList({required this.data});

  final SearchApiModel? data;

  @override
  Widget build(BuildContext context) {
    final items = data?.items ?? [];
    if (items.isEmpty) {
      return const Center(child: Text('検索キーワードを入力して検索してください'));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => _RepoListItem(item: items[index]),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'エラー',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('再試行')),
          ],
        ),
      ),
    );
  }
}

class _RepoListItem extends StatelessWidget {
  const _RepoListItem({required this.item});

  final Item item;

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
    );
  }
}
