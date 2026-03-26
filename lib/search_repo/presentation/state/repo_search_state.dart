// =============================================================================
// 検索の操作状態（一覧専用）
// =============================================================================

import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';

sealed class RepoSearchState {
  const RepoSearchState();

  const factory RepoSearchState.initial() = RepoSearchInitial._;
  const factory RepoSearchState.loading() = RepoSearchLoading._;
  const factory RepoSearchState.success({required SearchApiModel searchModel}) =
      RepoSearchSuccess._;
  const factory RepoSearchState.error(GithubRepoApiException exception) =
      RepoSearchError._;
}

final class RepoSearchInitial extends RepoSearchState {
  const RepoSearchInitial._() : super();
}

final class RepoSearchLoading extends RepoSearchState {
  const RepoSearchLoading._();
}

final class RepoSearchSuccess extends RepoSearchState {
  const RepoSearchSuccess._({required this.searchModel});

  final SearchApiModel searchModel;
}

final class RepoSearchError extends RepoSearchState {
  const RepoSearchError._(this.exception);

  final GithubRepoApiException exception;
}
