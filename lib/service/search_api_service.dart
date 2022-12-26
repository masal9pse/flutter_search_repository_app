import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_engineer_codecheck/const/response_message.dart';
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
        code: ResponseStatus.userInvalidResponse,
        errorResponse: '無効な値が返却されました。',
      );
    } on HttpException {
      return Failure(
        code: ResponseStatus.noInternet,
        errorResponse: ResponesMessage.noConnectionMessage,
      );
    } on FormatException {
      return Failure(
        code: ResponseStatus.noInternet,
        errorResponse: ResponesMessage.formatExceptionMessage,
      );
    } on TimeoutException {
      return Failure(
        code: ResponseStatus.timeoutError,
        errorResponse: ResponesMessage.timeoutMessage,
      );
    } catch (e) {
      return Failure(
        code: ResponseStatus.unknownError,
        errorResponse: ResponesMessage.otherExceptionMessage,
      );
    }
  }
}
