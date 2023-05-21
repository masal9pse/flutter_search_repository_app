import 'package:flutter_engineer_codecheck/application/config/flavor.dart';
import 'package:flutter_engineer_codecheck/application/const/enum/flavor.dart';
import 'package:flutter_engineer_codecheck/damain/repository/search_api_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// DI は特別に外レイヤーをimportする
import 'package:flutter_engineer_codecheck/infrastructure/search_github_api_repository.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_fake_api_repository.dart';

final searchApiRepositoryProvider = Provider<SearchApiRepository>(
  ((ref) {
    switch (flavor) {
      case Flavor.dev:
        return SearchFakeApiRepository();
      case Flavor.devStg:
        return SearchGitHubApiRepository();
      case Flavor.stg:
        return SearchFakeApiRepository();
      case Flavor.prd:
        return SearchGitHubApiRepository();
    }
  }),
);
