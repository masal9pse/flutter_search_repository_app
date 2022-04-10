import 'dart:async';
import 'dart:convert';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:http/http.dart' as http;

class SearchApiService {
  Future<SearchApiModelStruct> getApiListInfo() async {
    try {
      final url = Uri.parse('https://api.github.com/search/repositories?q=q');
      const timeOutCount = 10;
      final response = await http
          .get(url)
          .timeout(const Duration(seconds: timeOutCount));
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final searchApiModelStruct = SearchApiModelStruct.fromJson(decoded);
        return searchApiModelStruct;
      } else {
        throw Exception('AuthRepositoryで例外が発生しました');
      }
    } on TimeoutException catch (_) {
      throw TimeoutException('AuthRepositoryでタイムアウトしました。');
    }
  }
}