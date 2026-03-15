import 'package:flutter_engineer_codecheck/core/result.dart';
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

  void setItems(SearchApiModel data) {
    state = data;
  }

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

  void setSingleItem(Item item) {
    state = SearchApiModel(totalCount: 1, items: [item]);
  }
}

final repoItemsProvider =
    NotifierProvider<RepoItemsNotifier, SearchApiModel>(RepoItemsNotifier.new);

// =============================================================================
// 検索の操作状態（一覧専用）
// =============================================================================

sealed class RepoSearchState {
  const RepoSearchState();
}

class RepoSearchInitial extends RepoSearchState {
  const RepoSearchInitial();
}

class RepoSearchLoading extends RepoSearchState {
  const RepoSearchLoading();
}

class RepoSearchSuccess extends RepoSearchState {
  const RepoSearchSuccess();
}

class RepoSearchError extends RepoSearchState {
  const RepoSearchError({required this.exception});

  final GithubRepoApiException exception;
}

class RepoSearchNotifier extends Notifier<RepoSearchState> {
  GithubRepoApi get _api => ref.read(githubRepoApiProvider);

  @override
  RepoSearchState build() => const RepoSearchInitial();

  Future<void> search(String q) async {
    state = const RepoSearchLoading();
    final result = await _api.searchRepositories(q: q);
    switch (result) {
      case Success<SearchApiModel, GithubRepoApiException>(:final data):
        ref.read(repoItemsProvider.notifier).setItems(data);
        state = const RepoSearchSuccess();
      case Failure<SearchApiModel, GithubRepoApiException>(:final exception):
        state = RepoSearchError(exception: exception);
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
