part of '../repo_search_screen.dart';

class _SearchResult extends ConsumerWidget {
  const _SearchResult();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchState = ref.watch(repoSearchStateProvider);
    return switch (searchState) {
      RepoSearchInitial() => const _InitialView(),
      RepoSearchLoading() => const Center(child: CircularProgressIndicator()),
      RepoSearchSuccess() =>
        _RepoList(data: ref.watch(repoItemsProvider)),
      RepoSearchError(:final exception) => _ExceptionView(exception: exception),
    };
  }
}
