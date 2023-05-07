import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchApiRepositoryProvider = Provider<SearchApiRepository>(
  ((ref) {
    return SearchApiRepositoryImpl(searchApiClient: SearchApiClient());
  }),
);