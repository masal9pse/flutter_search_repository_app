part of '../repo_search_screen.dart';

class _SearchForm extends HookConsumerWidget {
  const _SearchForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: '');
    final isNotEmpty = useListenableSelector(
      controller,
      () => controller.text.trim().isNotEmpty,
    );
    final searchState = ref.watch(repoSearchStateProvider);

    final onSearchCallBack = useMemoized(
      () {
        if (isNotEmpty && searchState is! RepoSearchLoading) {
          return () => ref
              .read(repoSearchStateProvider.notifier)
              .search(controller.text.trim());
        }
      },
      [isNotEmpty, searchState],
    );

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
                hintText: 'flutter',
                border: OutlineInputBorder(),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
              onFieldSubmitted: (_) => onSearchCallBack?.call(),
            ),
          ),
          const SizedBox(width: 12),
          FilledButton.icon(
            onPressed: onSearchCallBack,
            icon: searchState is RepoSearchLoading
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
