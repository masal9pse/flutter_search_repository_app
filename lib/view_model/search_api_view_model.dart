import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/api_status.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/service/search_api_service.dart';

class SearchApiViewModel with ChangeNotifier {
  SearchApiViewModel(this.searchApiService);
  late final SearchApiService searchApiService;
  SearchApiModelStruct? _searchApiModelStruct;
  SearchApiModelStruct? get searchApiModelStruct => _searchApiModelStruct;
  // SearchApiError _searchApiError;

  bool _isEnabled = true;
  bool get isEnabled => _isEnabled;
  final formController = TextEditingController();
  // SearchApiError get searchApiError => _searchApiError;

  // set searchApiError () {
  //   _searchApiError =
  // }

  set isEnabled(bool value) {
    _isEnabled = value;
    notifyListeners();
  }

  set searchApiModelStruct(SearchApiModelStruct? value) {
    _searchApiModelStruct = value;
    notifyListeners();
  }

  /// API 通信 と View層への通知
  Future<void> fetchSearchApiModelStruct(String text) async {
    // void fetchSearchApiModelStruct(String text) async {
    final response = await searchApiService.getApiListInfo(text);
    if (response is Success) {
      searchApiModelStruct = response.response as SearchApiModelStruct;
    } else if (response is Failure) {}
    isEnabled = true;
  }
}
