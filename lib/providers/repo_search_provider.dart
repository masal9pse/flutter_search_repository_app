import 'package:flutter_engineer_codecheck/search/github_repo_api.dart';
import 'package:flutter_engineer_codecheck/search/search_repo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  const RepoSearchError({
    required this.error,
    required this.stackTrace,
    required this.query,
  });

  final Object error;
  final StackTrace stackTrace;
  final String query;
}

class RepoSearchNotifier extends Notifier<RepoSearchState> {
  GithubRepoApi get _api => ref.read(githubRepoApiProvider);

  @override
  RepoSearchState build() => const RepoSearchInitial();

  Future<void> search(String q) async {
    final query = q.trim().isEmpty ? 'Q' : q.trim();
    try {
      state = const RepoSearchLoading();
      final data = await _api.searchRepositories(q: query);
      state = RepoSearchSuccess(data: data, query: query);
    } catch (e, st) {
      state = RepoSearchError(error: e, stackTrace: st, query: query);
    }
  }
}

final repoSearchNotifierProvider =
    NotifierProvider<RepoSearchNotifier, RepoSearchState>(
  RepoSearchNotifier.new,
);
