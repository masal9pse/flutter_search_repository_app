import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/domain/model/result.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';

typedef ApiResults = Result<SearchApiModel, DioException>;

class SearchApiRepository {
  Future<ApiResults> getApiListInfo({
    required String input,
  }) async {
    final dio = Dio(
      BaseOptions(
        connectTimeout: Duration(seconds: 2),
        receiveTimeout: Duration(seconds: 3),
      ),
    );
    try {
      // throw DioException.connectionError(requestOptions: RequestOptions(), reason: 'abc');
      final response =
          await dio.get('https://api.github.com/search/repositories?q=$input');
      final searchApiModel = SearchApiModel.fromJson(response.data);
      return Result.success(searchApiModel);
    } on DioException catch (e) {
      return Result.failure(e);
    }
  }
}
