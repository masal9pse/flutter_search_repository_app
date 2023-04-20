import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';

class SearchApiViewModel with ChangeNotifier {
  SearchApiViewModel({required this.searchApiRepository});
  final SearchApiRepository searchApiRepository;
  Future<Result<SearchApiModelStruct, ApiError>>? result;

  final formController = TextEditingController();

  /// API 通信 と View層への通知
  Future<void> fetchSearchApiModelStruct({required String text}) async {
    final response = searchApiRepository.getApiListInfo(input: text);
    result = response;
    notifyListeners();
  }
}
