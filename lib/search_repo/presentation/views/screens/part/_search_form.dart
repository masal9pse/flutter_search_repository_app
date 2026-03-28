part of '../repo_search_screen.dart';

class _SearchForm extends HookConsumerWidget {
  const _SearchForm();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final controller = TextEditingController(text: '');
    final controller = useTextEditingController(text: '');
    final isNotEmpty = useListenableSelector(
      controller,
      () => controller.text.isNotEmpty,
    );
    final searchState = ref.watch(repoSearchStateProvider);

    VoidCallback? onSearchPressed;
    if (isNotEmpty && searchState is! RepoSearchLoading) {
      onSearchPressed = () => ref
          .read(repoSearchStateProvider.notifier)
          .search(controller.text);
    }

    final Widget searchIcon;
    if (searchState is RepoSearchLoading) {
      searchIcon = const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    } else {
      searchIcon = const Icon(Icons.search);
    }

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
            onPressed: onSearchPressed,
            icon: searchIcon,
            label: const Text('検索'),
          ),
        ],
      ),
    );
  }
}
