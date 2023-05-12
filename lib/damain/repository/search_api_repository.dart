import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/damain/types/error.dart';
import 'package:flutter_engineer_codecheck/damain/types/result.dart';

abstract class SearchApiRepository {
  Future<Result<SearchApiModelStruct,AppError>> getApiListInfo({
    required String input,
  });
}
