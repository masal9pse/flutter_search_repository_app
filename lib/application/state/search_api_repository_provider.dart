import 'package:flutter_engineer_codecheck/infrastructure/search_api_client.dart';
import 'package:flutter_engineer_codecheck/damain/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/damain/repository/search_api_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchApiRepositoryProvider = Provider<SearchApiRepository>(
  ((ref) {
    return SearchApiRepositoryImpl(searchApiClient: SearchApiClient());
  }),
);