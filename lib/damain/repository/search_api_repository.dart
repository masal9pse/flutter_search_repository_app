import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';

abstract class SearchApiRepository {
  Future<SearchApiModelStruct>? getApiListInfo({
    required String input,
  });
}
