import 'package:flutter_engineer_codecheck/core/result.dart';
import 'package:flutter_engineer_codecheck/search_repo/presentation/state/repo_search_state.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final githubRepoApiProvider = Provider<GithubRepoApi>((ref) => GithubRepoApi());

// =============================================================================
// データソース（SSOT）- 一覧・詳細で共有
// =============================================================================

class RepoItemsNotifier extends Notifier<SearchApiModel> {
  @override
  SearchApiModel build() => const SearchApiModel();

  SearchApiModel get items => state;
  set items(SearchApiModel data) => state = data;

  /// 詳細画面から更新された場合に呼び出す
  void updateItem(String owner, String repo, Item item) {
    final items = state.items;
    final index = items.indexWhere(
      (e) => e.owner.login == owner && e.name == repo,
    );
    final newItems = List<Item>.from(items);
    if (index >= 0) {
      newItems[index] = item;
    } else {
      newItems.add(item);
    }
    state = SearchApiModel(
      totalCount: state.totalCount,
      items: newItems,
    );
  }
}

final repoItemsProvider =
    NotifierProvider<RepoItemsNotifier, SearchApiModel>(RepoItemsNotifier.new);

class RepoSearchNotifier extends Notifier<RepoSearchState> {
  GithubRepoApi get _api => ref.read(githubRepoApiProvider);

  @override
  RepoSearchState build() => const RepoSearchState.initial();

  Future<void> search(String q) async {
    state = const RepoSearchState.loading();
    final result = await _api.searchRepositories(q: q);
    switch (result) {
      case Success<SearchApiModel, GithubRepoApiException>(:final data):
        ref.read(repoItemsProvider.notifier).items = data;
        state = RepoSearchState.success(searchModel: data);
      case Failure<SearchApiModel, GithubRepoApiException>(:final exception):
        state = RepoSearchState.error(exception);
    }
  }
}

final repoSearchStateProvider =
    NotifierProvider<RepoSearchNotifier, RepoSearchState>(
  RepoSearchNotifier.new,
);

// =============================================================================
// 詳細取得（詳細専用）- owner/repo ごと
// FutureProvider: loading / data / error の3パターン
// =============================================================================

final AutoDisposeFutureProviderFamily<Item, ({String owner, String repo})>
    repoDetailProvider =
    FutureProvider.autoDispose.family<Item, ({String owner, String repo})>(
  (ref, arg) async {
    final api = ref.read(githubRepoApiProvider);
    final itemsNotifier = ref.read(repoItemsProvider.notifier);
    final result = await api.getRepository(
      owner: arg.owner,
      repo: arg.repo,
    );

    switch (result) {
      case Success<Item, GithubRepoApiException>(:final data):
        itemsNotifier.updateItem(arg.owner, arg.repo, data);
        return data;
      case Failure<Item, GithubRepoApiException>(:final exception):
        throw exception;
    }
  },
);
