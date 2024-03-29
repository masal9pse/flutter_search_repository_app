import 'dart:async';
import 'dart:convert';
import 'package:flutter_engineer_codecheck/domain/model/error.dart';
import 'package:flutter_engineer_codecheck/domain/model/result.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/domain/repository/search_api_repository.dart';
import 'package:http/http.dart' as http;

class SearchGitHubApiRepository implements SearchApiRepository {
  @override
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
    } on Exception catch (_) {
      return const Result.failure(AppError.fetchError());
    }
  }
}
