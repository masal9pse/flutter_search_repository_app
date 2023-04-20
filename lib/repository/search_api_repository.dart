import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';

abstract class SearchApiRepository {
  Future<Result<SearchApiModelStruct, ApiError>>? getApiListInfo({
    required String input,
  });
}
