import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_engineer_codecheck/domain/model/result.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:http/http.dart' as http;
// typedef ApiResults = Result<SearchApiModel,AppError>;
typedef ApiResults = Result<SearchApiModel,Exception>;

class SearchApiRepository  {
  Future<ApiResults> getApiListInfo({
    required String input,
  }) async {
    try {
      final url =
          Uri.parse('https://api.github.com/search/repositories?q=$input');
      const timeOutCount = 5;
      final response =
          await http.get(url).timeout(const Duration(seconds: timeOutCount));
      final decoded = json.decode(response.body) as Map<String, dynamic>;
        final searchApiModel = SearchApiModel.fromJson(decoded);
      return Result.success(searchApiModel);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
