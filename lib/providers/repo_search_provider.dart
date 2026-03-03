import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../search/github_repo_api.dart';
import '../search/search_repo_model.dart';

final githubRepoApiProvider = Provider<GithubRepoApi>((ref) => GithubRepoApi());

class RepoSearchNotifier extends StateNotifier<AsyncValue<SearchApiModel?>> {
  RepoSearchNotifier(this._api) : super(const AsyncValue.data(null));

  final GithubRepoApi _api;

  Future<void> search(String q) async {
    final query = q.trim().isEmpty ? 'Q' : q.trim();
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _api.searchRepositories(q: query));
  }
}

final repoSearchNotifierProvider =
    StateNotifierProvider<RepoSearchNotifier, AsyncValue<SearchApiModel?>>((ref) {
  return RepoSearchNotifier(ref.read(githubRepoApiProvider));
});
