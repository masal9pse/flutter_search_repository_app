import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';

class SearchApiViewModel with ChangeNotifier {
  SearchApiModelStruct? _searchApiModelStruct;
  SearchApiModelStruct? get searchApiModelStruct => _searchApiModelStruct;

  set searchApiModelStruct(SearchApiModelStruct? value) {
    _searchApiModelStruct = value;
    notifyListeners();
  }

  /// API 通信 と View層への通知
  Future<SearchApiModelStruct?> fetchSearchApiModelStruct(String text) async {
    try {
      final fetchInfo = await SearchApiService().getApiListInfo(text);
      searchApiModelStruct = fetchInfo;
      return fetchInfo;
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }
}