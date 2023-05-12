import 'package:flutter_engineer_codecheck/damain/types/error.dart';
import 'package:flutter_engineer_codecheck/damain/types/result.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_api_client.dart';
import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/damain/repository/search_api_repository.dart';

class SearchApiRepositoryImpl implements SearchApiRepository {
  final SearchApiClient searchApiClient;

  SearchApiRepositoryImpl({required this.searchApiClient});

  @override
  Future<Result<SearchApiModelStruct,AppError>> getApiListInfo({
    required String input,
  }) {
    return searchApiClient.getApiListInfo(input: input);
  }
}
