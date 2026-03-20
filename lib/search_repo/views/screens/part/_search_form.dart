part of '../repo_search_screen.dart';

class _SearchForm extends HookConsumerWidget {
  const _SearchForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: '');

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
                  .read(repoSearchStateProvider.notifier)
                  .search(controller.text),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: ref.watch(repoSearchStateProvider) is RepoSearchLoading
                ? null
                : () => ref
                    .read(repoSearchStateProvider.notifier)
                    .search(controller.text),
            icon: ref.watch(repoSearchStateProvider) is RepoSearchLoading
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
