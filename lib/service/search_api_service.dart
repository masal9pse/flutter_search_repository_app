import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_engineer_codecheck/extention/custom_exception.dart';
import 'package:flutter_engineer_codecheck/model/api_status.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:http/http.dart' as http;

class SearchApiService {
  // widget-testの際にオプショナルにしないとなぜかnull-checkで引っかかってエラーになった。
  Future<Object>? getApiListInfo(String input) async {
    try {
      throw HttpException(11.toString()); 
      // final url =
      //     Uri.parse('https://api.github.com/search/repositories?q=$input');
      // const timeOutCount = 5;
      // final response =
      //     await http.get(url).timeout(const Duration(seconds: timeOutCount));
      // final decoded = json.decode(response.body) as Map<String, dynamic>;
      // if (response.statusCode == 200) {
      //   final searchApiModelStruct = SearchApiModelStruct.fromJson(decoded);
      //   final a = Success(code: null,response: searchApiModelStruct);
      //   // return Success(code: null,response: searchApiModelStruct);
      //   return a;
      // } else if (response.statusCode == 300) {
      //   throw NotModifiedException(response.body.toString());
      // } else if (response.statusCode == 422) {
      //   throw BadRequestException(response.body.toString());
      // } else if (response.statusCode == 503) {
      //   throw ServerProblemException(response.body.toString());
      // } else {
      //   throw Exception(response.body.toString());
      // }
    } on HttpException {
      final o = Failure(code: 100, errorResponse: 'No Internet');
      return Failure(code: 100, errorResponse: 'No Internet');
    } on TimeoutException {
      return Failure(code: 101,errorResponse: 'タイムアウトしました');
    }
  }
}