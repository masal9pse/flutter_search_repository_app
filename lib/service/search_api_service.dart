import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_engineer_codecheck/const/response_status.dart';
import 'package:flutter_engineer_codecheck/model/api_status.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:http/http.dart' as http;

class SearchApiService {
  Future<Object>? getApiListInfo(String input) async {
    try {
      final url =
          Uri.parse('https://api.github.com/search/repositories?q=$input');
      const timeOutCount = 5;
      final response =
          await http.get(url).timeout(const Duration(seconds: timeOutCount));
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final searchApiModelStruct = SearchApiModelStruct.fromJson(decoded);
        final success = Success(code: null, response: searchApiModelStruct);
        return success;
      }
      return Failure(
          code: USER_INVALID_RESPONSE, errorResponse: '無効な値が返却されました。');
    } on HttpException {
      return Failure(code: NO_INTERNET, errorResponse: 'インターネットに接続できませんでした。');
    } on FormatException {
      return Failure(code: NO_INTERNET, errorResponse: '無効な方式です。');
    } on TimeoutException {
      return Failure(code: 101, errorResponse: 'タイムアウトしました');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: '不明なエラーです。');
    }
  }
}
