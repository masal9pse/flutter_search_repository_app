import 'dart:async';
import 'dart:convert';
import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/damain/types/error.dart';
import 'package:flutter_engineer_codecheck/damain/types/result.dart';
import 'package:http/http.dart' as http;

class SearchApiClient {
  Future<Result<SearchApiModelStruct,AppError>> getApiListInfo({
    required String input,
  }) async {
    try {
      final url =
          Uri.parse('https://api.github.com/search/repositories?q=$input');
      const timeOutCount = 5;
      final response =
          await http.get(url).timeout(const Duration(seconds: timeOutCount));
      final decoded = json.decode(response.body) as Map<String, dynamic>;
        final searchApiModelStruct = SearchApiModelStruct.fromJson(decoded);
      return Result.success(searchApiModelStruct);
    } on Exception catch (_) {
      return const Result.failure(AppError.fetchError());
    }
  }
}
