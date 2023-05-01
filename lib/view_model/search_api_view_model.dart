import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchApiNotifier with ChangeNotifier {
  SearchApiNotifier({required this.searchApiRepository});
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

final searchApiProvider = ChangeNotifierProvider<SearchApiNotifier>((ref) {
  // final repository = ref.watch<SearchApiRepository>(searchApiProvider);
  return SearchApiNotifier(searchApiRepository: SearchApiRepositoryImpl(searchApiClient: SearchApiClient()));
  // return SearchApiNotifier(searchApiRepository: repository);
});
a