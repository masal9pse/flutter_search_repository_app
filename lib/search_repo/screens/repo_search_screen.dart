import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/search_repo/providers/repo_search_provider.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';
import 'package:flutter_engineer_codecheck/search_repo/screens/repo_detail_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RepoSearchScreen extends ConsumerWidget {
  const RepoSearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub リポジトリ検索'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SearchForm(),
          Divider(height: 1),
          Expanded(child: _SearchResult()),
        ],
      ),
    );
  }
}

class _SearchResult extends ConsumerWidget {
  const _SearchResult();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return switch (ref.watch(repoSearchNotifierProvider)) {
      RepoSearchInitial() => const _InitialView(),
      RepoSearchLoading() => const Center(child: CircularProgressIndicator()),
      RepoSearchSuccess(:final data) => _RepoList(data: data),
      RepoSearchError(:final exception) => _ExceptionView(exception: exception),
    };
  }
}

class _InitialView extends StatelessWidget {
  const _InitialView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('検索キーワードを入力して検索してください'));
  }
}

class _SearchForm extends HookConsumerWidget {
  const _SearchForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: '');

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
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              onFieldSubmitted: (_) => ref
                  .read(repoSearchNotifierProvider.notifier)
                  .search(controller.text),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed:
                ref.watch(repoSearchNotifierProvider) is RepoSearchLoading
                    ? null
                    : () => ref
                        .read(repoSearchNotifierProvider.notifier)
                        .search(controller.text),
            icon: ref.watch(repoSearchNotifierProvider) is RepoSearchLoading
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

  final SearchApiModel data;

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

class _ExceptionView extends ConsumerWidget {
  const _ExceptionView({required this.exception});

  final GithubRepoApiException exception;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (exception) {
      case NetworkGithubRepoApiException() ||
            CanceledGithubRepoApiException() ||
            BadCertificateGithubRepoApiException() ||
            InvalidResponseGithubRepoApiException() ||
            UnknownGithubRepoApiException() ||
            ServerGithubRepoApiException() ||
            NotFoundGithubRepoApiException() ||
            UnauthorizedGithubRepoApiException() ||
            RateLimitGithubRepoApiException() ||
            HttpGithubRepoApiException():
        Column(
          children: [
            Text(exception.message),
            const Text('widget分けるイメージ1'),
          ],
        );
      case TimeoutGithubRepoApiException():
        return Column(
          children: [
            Text(exception.message),
            const Text('widget分けるイメージ2'),
          ],
        );
    }
    return const Text('想定外エラー');
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
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RepoDetailScreen(id: item.id),
          ),
        );
      },
    );
  }
}
