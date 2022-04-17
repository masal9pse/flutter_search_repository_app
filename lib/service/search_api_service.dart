import 'dart:async';
import 'dart:convert';
import 'package:flutter_engineer_codecheck/extention/custom_exception.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:http/http.dart' as http;

class SearchApiService {
  Future<SearchApiModelStruct> getApiListInfo(String input) async {
    try {
      final url =
          Uri.parse('https://api.github.com/search/repositories?q=$input');
      const timeOutCount = 3;
      final response =
          await http.get(url).timeout(const Duration(seconds: timeOutCount));
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        final searchApiModelStruct = SearchApiModelStruct.fromJson(decoded);
        return searchApiModelStruct;
      } else if (response.statusCode == 300) {
        throw NotModifiedException(response.body.toString());
      } else if (response.statusCode == 422) {
        throw BadRequestException(response.body.toString());
      } else if (response.statusCode == 503) {
        throw ServerProblemException(response.body.toString());
      } else {
        throw Exception(response.body.toString());
      }
    } on TimeoutException catch (e) {
      throw TimeoutException(e.toString());
    }
  }
}