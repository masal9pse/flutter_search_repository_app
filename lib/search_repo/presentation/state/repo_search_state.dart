// =============================================================================
// 検索の操作状態（一覧専用）
// =============================================================================

import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';

sealed class RepoSearchState {
  const RepoSearchState();

  const factory RepoSearchState.initial() = RepoSearchInitial._;
  const factory RepoSearchState.loading() = RepoSearchLoading._;
  const factory RepoSearchState.success() = RepoSearchSuccess._;
  const factory RepoSearchState.error(GithubRepoApiException exception) =
      RepoSearchError._;
}

final class RepoSearchInitial extends RepoSearchState {
  const RepoSearchInitial._();
}

final class RepoSearchLoading extends RepoSearchState {
  const RepoSearchLoading._();
}

final class RepoSearchSuccess extends RepoSearchState {
  const RepoSearchSuccess._();
}

final class RepoSearchError extends RepoSearchState {
  const RepoSearchError._(this.exception);

  final GithubRepoApiException exception;
}
