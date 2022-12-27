import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';

class SearchApiViewModel with ChangeNotifier {
  SearchApiViewModel(this.searchApiService);
  late final SearchApiService searchApiService;
  SearchApiModelStruct? _searchApiModelStruct;
  SearchApiModelStruct? get searchApiModelStruct => _searchApiModelStruct;
  ApiError? _apiError;
  ApiError? get apiError => _apiError;

  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;
  final formController = TextEditingController();

  set isEnabled(bool value) {
    _isEnabled = value;
    notifyListeners();
  }

  set searchApiModelStruct(SearchApiModelStruct? value) {
    _searchApiModelStruct = value;
    notifyListeners();
  }

  set apiError(ApiError? apiError) {
    _apiError = apiError;
    notifyListeners();
  }

  /// API 通信 と View層への通知
  Future<void> fetchSearchApiModelStruct(String text) async {
    final response = await searchApiService.getApiListInfo(input: text);
    response?.when(
      success: (SearchApiModelStruct searchApiModelStructApiData) {
        searchApiModelStruct = searchApiModelStructApiData;
      },
      failure: (ApiError apiErrorData) {
        apiError = apiErrorData;
      },
    );
  }
}
