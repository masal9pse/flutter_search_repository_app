import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';
import 'package:provider/provider.dart';

class SearchApiViewModel extends StateNotifier<SearchApiModelStruct> {
  // SearchApiViewModel({required this.searchApiRepository}):super(const SearchApiModelStruct(items: [], totalCount: 0));
  // SearchApiViewModel({required this.context}):super(const SearchApiModelStruct(items: [], totalCount: 0));
  SearchApiViewModel({required this.read}):super(const SearchApiModelStruct(items: [], totalCount: 0));
  // final BuildContext context;
  final T Function<T>() read;
  // final Locator read;
  
  // final SearchApiRepository searchApiRepository;
  // SearchApiRepository get searchApiRepository => read<SearchApiRepository>();
  SearchApiRepository get searchApiRepository => read<SearchApiRepositoryImpl>();

  // final formController = TextEditingController();

  /// API 通信 と View層への通知
  Future<void> fetchSearchApiModelStruct({required String text}) async {
    final response = await searchApiRepository.getApiListInfo(input: text);
    state = state.copyWith(items: response!.items,totalCount: response.totalCount);
  }
}
