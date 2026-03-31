import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';

/// GitHub API 非依存の固定レスポンス（mock フレーバー専用）。
abstract final class GithubRepoMockData {
  static const Repo _itemA = Repo(
    owner: Owner(
      login: 'flutter',
      avatarUrl: 'https://avatars.githubusercontent.com/u/14101776?v=4',
    ),
    id: 31792824,
    name: 'flutter',
    stargazersCount: 100000,
    watchersCount: 3500,
    language: 'Dart',
    forksCount: 20000,
    openIssuesCount: 5000,
  );

  static const Repo _itemB = Repo(
    owner: Owner(
      login: 'dart-lang',
      avatarUrl: 'https://avatars.githubusercontent.com/u/1609975?v=4',
    ),
    id: 436730213,
    name: 'sdk',
    stargazersCount: 9000,
    watchersCount: 800,
    language: 'Dart',
    forksCount: 1000,
    openIssuesCount: 200,
  );

  /// 検索 API の固定レスポンス（クエリに依存しない）。
  static const RepoList searchResult = RepoList(
    totalCount: 2,
    items: [_itemA, _itemB],
  );

  /// 詳細 API の固定レスポンス。一覧のいずれかと一致すればその項目、一致しなければ [_itemA]。
  static Repo repositoryDetail({
    required String owner,
    required String repo,
  }) {
    for (final item in searchResult.items) {
      if (item.owner.login == owner && item.name == repo) {
        return item;
      }
    }
    return _itemA;
  }
}
