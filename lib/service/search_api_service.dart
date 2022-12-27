import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_engineer_codecheck/const/response_message.dart';
import 'package:flutter_engineer_codecheck/const/response_status.dart';
import 'package:flutter_engineer_codecheck/model/api_error.dart';
import 'package:flutter_engineer_codecheck/model/result.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:http/http.dart' as http;

class SearchApiService {
  Future<Result<SearchApiModelStruct, ApiError>>? getApiListInfo({
    required String input,
  }) async {
    try {
      final url =
          Uri.parse('https://api.github.com/search/repositories?q=$input');
      const timeOutCount = 5;
      final response =
          await http.get(url).timeout(const Duration(seconds: timeOutCount));
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final searchApiModelStruct = SearchApiModelStruct.fromJson(decoded);
        return Result.success(searchApiModelStruct);
      }
      return const Result.failure(
        ApiError(
          code: ResponseStatus.userInvalidStatus,
          message: ResponesMessage.invalidMessage,
        ),
      );
    } on HttpException {
      return const Result.failure(
        ApiError(
          code: ResponseStatus.noInternetStatus,
          message: ResponesMessage.noConnectionMessage,
        ),
      );
    } on FormatException {
      return const Result.failure(
        ApiError(
          code: ResponseStatus.invalidFormatStatus,
          message: ResponesMessage.invalidMessage,
        ),
      );
    } on TimeoutException {
      return const Result.failure(
        ApiError(
          code: ResponseStatus.timeoutStatus,
          message: ResponesMessage.timeoutMessage,
        ),
      );
    } on Exception {
      return const Result.failure(
        ApiError(
          code: ResponseStatus.unknownStatus,
          message: ResponesMessage.otherExceptionMessage,
        ),
      );
    }
  }
}
