import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';

abstract class SearchApiRepository {
  Future<SearchApiModelStruct>? getApiListInfo({
    required String input,
  });
}
