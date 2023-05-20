import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/damain/types/error.dart';
import 'package:flutter_engineer_codecheck/damain/types/result.dart';

typedef ApiResults = Result<SearchApiModelStruct,AppError>;

abstract class SearchApiRepository {
  Future<ApiResults> getApiListInfo({
    required String input,
  });
}
