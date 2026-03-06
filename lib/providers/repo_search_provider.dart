import 'package:flutter_engineer_codecheck/core/result.dart';
import 'package:flutter_engineer_codecheck/search/github_repo_api.dart';
import 'package:flutter_engineer_codecheck/search/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search/search_repo_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final githubRepoApiProvider = Provider<GithubRepoApi>((ref) => GithubRepoApi());

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
  const RepoSearchSuccess({required this.data, required this.query});

  final SearchApiModel data;
  final String query;
}

class RepoSearchError extends RepoSearchState {
  const RepoSearchError({required this.exception, required this.query});

  final GithubRepoApiException exception;
  final String query;
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
        state = RepoSearchSuccess(data: data, query: q);
      case Error<SearchApiModel, GithubRepoApiException>(:final exception):
        state = RepoSearchError(exception: exception, query: q);
    }
  }
}

final repoSearchNotifierProvider =
    NotifierProvider<RepoSearchNotifier, RepoSearchState>(
  RepoSearchNotifier.new,
);
