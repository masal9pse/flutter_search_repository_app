import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchApiRepositoryImpl implements SearchApiRepository {
  final SearchApiClient searchApiClient;

  SearchApiRepositoryImpl({required this.searchApiClient});

  @override
  Future<Result<SearchApiModelStruct, ApiError>>? getApiListInfo({
    required String input,
  }) {
    return searchApiClient.getApiListInfo(input: input);
  }
}

final searchApiRepositoryProvider = Provider<SearchApiRepository>(
  ((ref) => SearchApiRepositoryImpl(searchApiClient: SearchApiClient())),
);
