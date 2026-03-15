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
// 詳細の操作状態（詳細専用）- owner/repo ごと
// =============================================================================

sealed class RepoDetailState {
  const RepoDetailState();
}

class RepoDetailInitial extends RepoDetailState {
  const RepoDetailInitial();
}

class RepoDetailLoading extends RepoDetailState {
  const RepoDetailLoading();
}

class RepoDetailSuccess extends RepoDetailState {
  const RepoDetailSuccess({required this.data});

  final Item data;
}

class RepoDetailError extends RepoDetailState {
  const RepoDetailError({required this.exception});

  final GithubRepoApiException exception;
}

class RepoDetailNotifier
    extends FamilyNotifier<RepoDetailState, ({String owner, String repo})> {
  GithubRepoApi get _api => ref.read(githubRepoApiProvider);
  RepoItemsNotifier get _items => ref.read(repoItemsProvider.notifier);

  @override
  RepoDetailState build(({String owner, String repo}) arg) =>
      const RepoDetailInitial();

  Future<void> fetch() async {
    state = const RepoDetailLoading();
    final result = await _api.getRepository(
      owner: arg.owner,
      repo: arg.repo,
    );
    switch (result) {
      case Success<Item, GithubRepoApiException>(:final data):
        _items.updateItem(arg.owner, arg.repo, data);
        state = RepoDetailSuccess(data: data);
      case Failure<Item, GithubRepoApiException>(:final exception):
        state = RepoDetailError(exception: exception);
    }
  }
}

final NotifierProviderFamily<RepoDetailNotifier, RepoDetailState,
        ({String owner, String repo})> repoDetailStateProvider =
    NotifierProvider.family<RepoDetailNotifier, RepoDetailState,
        ({String owner, String repo})>(RepoDetailNotifier.new);
