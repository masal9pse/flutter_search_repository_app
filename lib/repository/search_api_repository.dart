import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';

abstract class SearchApiRepository {
  // Future<Result<SearchApiModelStruct, ApiError>>? getApiListInfo({
  Future<SearchApiModelStruct>? getApiListInfo({
    required String input,
  });
}
