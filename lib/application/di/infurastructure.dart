// DI は特別に外レイヤーをimportする
import 'package:flutter_engineer_codecheck/infrastructure/search_github_api_repository.dart';
import 'package:flutter_engineer_codecheck/damain/repository/search_api_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchApiRepositoryProvider = Provider<SearchApiRepository>(
  ((ref) {
    return SearchGitHubApiRepository();
  }),
);