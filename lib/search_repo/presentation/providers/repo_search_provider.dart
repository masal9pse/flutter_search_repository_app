import 'dart:async';

import 'package:flutter_engineer_codecheck/core/result.dart';
import 'package:flutter_engineer_codecheck/search_repo/presentation/state/repo_search_state.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_env.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final githubRepoApiProvider = Provider<GithubRepoApi>((ref) => GithubRepoApi());

// =============================================================================
// データソース（SSOT）- 一覧・詳細で共有
// =============================================================================

class RepoItemsNotifier extends Notifier<RepoList> {
  @override
  RepoList build() => const RepoList();

  RepoList get items => state;
  set items(RepoList data) => state = data;

  /// 詳細画面から更新された場合に呼び出す
  void updateItem(String owner, String repo, Repo item) {
    final items = state.items;
    final index = items.indexWhere(
      (e) => e.owner.login == owner && e.name == repo,
    );
    final newItems = List<Repo>.from(items);
    if (index >= 0) {
      newItems[index] = item;
    } else {
      newItems.add(item);
    }
    state = RepoList(
      totalCount: state.totalCount,
      items: newItems,
    );
  }
}

final repoItemsProvider =
    NotifierProvider<RepoItemsNotifier, RepoList>(RepoItemsNotifier.new);

const _searchMinDuration = Duration(seconds: 1);

class RepoSearchNotifier extends Notifier<RepoSearchStatus> {
  GithubRepoApi get _api => ref.read(githubRepoApiProvider);

  @override
  RepoSearchStatus build() => const RepoSearchStatus.initial();

  Future<void> search(String q) async {
    state = const RepoSearchStatus.loading();
    final result = await _api.searchRepositories(q: q);
    if (useMockGithubApi) {
      await Future<void>.delayed(_searchMinDuration);
    }
    switch (result) {
      case Success<RepoList, GithubRepoApiException>(:final data):
        ref.read(repoItemsProvider.notifier).items = data;
        state = const RepoSearchStatus.success();
      case Failure<RepoList, GithubRepoApiException>(:final exception):
        state = RepoSearchStatus.error(exception);
    }
  }
}

final repoSearchStateProvider =
    NotifierProvider<RepoSearchNotifier, RepoSearchStatus>(
  RepoSearchNotifier.new,
);

// =============================================================================
// 詳細取得（詳細専用）- owner/repo ごと
// FutureProvider: loading / data / error の3パターン
// =============================================================================

final AutoDisposeFutureProviderFamily<Repo, ({String owner, String repo})>
    repoDetailProvider =
    FutureProvider.autoDispose.family<Repo, ({String owner, String repo})>(
  (ref, arg) async {
    final api = ref.read(githubRepoApiProvider);
    final itemsNotifier = ref.read(repoItemsProvider.notifier);
    final result = await api.getRepository(
      owner: arg.owner,
      repo: arg.repo,
    );

    switch (result) {
      case Success<Repo, GithubRepoApiException>(:final data):
        itemsNotifier.updateItem(arg.owner, arg.repo, data);
        return data;
      case Failure<Repo, GithubRepoApiException>(:final exception):
        throw exception;
    }
  },
);
