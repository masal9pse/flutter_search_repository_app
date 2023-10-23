import 'dart:convert';

import 'package:flutter_engineer_codecheck/damain/entity/search_api_model.dart';
import 'package:flutter_engineer_codecheck/damain/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/damain/types/error.dart';
import 'package:flutter_engineer_codecheck/damain/types/result.dart';
import 'package:flutter/services.dart' show rootBundle;

class SearchFakeApiRepository implements SearchApiRepository {
  @override
  Future<ApiResults> getApiListInfo({
    required String input,
  }) async {
    final loadedData = await rootBundle.loadString('assets/json/fake_api_mock_data.json');
    final decodedData = jsonDecode(loadedData);
    final convertedData = SearchApiModel.fromJson(decodedData);
    return Future.value(Result.success(convertedData));
  }
}

class SearchFakeErrorApiRepository implements SearchApiRepository {
  @override
  Future<ApiResults> getApiListInfo({
    required String input,
  }) {
    return Future.value(const Result.failure(AppError.fetchError()));
  }
}
