import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';

class SearchApiRepositoryImpl implements SearchApiRepository {
  final SearchApiClient searchApiClient;

  SearchApiRepositoryImpl({required this.searchApiClient});

  @override
  Future<SearchApiModelStruct>? getApiListInfo({
    required String input,
  }) {
    return searchApiClient.getApiListInfo(input: input);
  }
}
