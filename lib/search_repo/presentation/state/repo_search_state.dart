// =============================================================================
// 検索の操作状態（一覧専用）
// =============================================================================

import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';

sealed class RepoSearchStatus {
  const RepoSearchStatus();

  const factory RepoSearchStatus.initial() = RepoSearchInitial._;
  const factory RepoSearchStatus.loading() = RepoSearchLoading._;
  const factory RepoSearchStatus.success() = RepoSearchSuccess._;
  const factory RepoSearchStatus.error(GithubRepoApiException exception) =
      RepoSearchError._;
}

final class RepoSearchInitial extends RepoSearchStatus {
  const RepoSearchInitial._() : super();
}

final class RepoSearchLoading extends RepoSearchStatus {
  const RepoSearchLoading._();
}

final class RepoSearchSuccess extends RepoSearchStatus {
  const RepoSearchSuccess._() : super();
}

final class RepoSearchError extends RepoSearchStatus {
  const RepoSearchError._(this.exception);

  final GithubRepoApiException exception;
}
