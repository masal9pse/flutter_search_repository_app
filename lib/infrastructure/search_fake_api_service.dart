import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';

class SearchFakeApiService implements SearchApiRepository {
  @override
  Future<SearchApiModelStruct?> getApiListInfo({required String input}) async {
    final loadedData = await rootBundle.loadString('assets/json/fake_api_mock_data.json');
    final decodedData = jsonDecode(loadedData);
    final convertedData = SearchApiModelStruct.fromJson(decodedData);
    return convertedData;
  }
}