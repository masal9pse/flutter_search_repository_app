import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

class SearchApiViewModel extends StateNotifier<SearchApiModelStruct> {
  SearchApiViewModel({required this.searchApiRepository}):super(const SearchApiModelStruct(items: [], totalCount: 0));
  
  final SearchApiRepository searchApiRepository;

  // final formController = TextEditingController();

  /// API 通信 と View層への通知
  Future<void> fetchSearchApiModelStruct({required String text}) async {
    final response = await searchApiRepository.getApiListInfo(input: text);
    state = state.copyWith(items: response!.items,totalCount: response.totalCount);
    int k = 3;
  }
}
