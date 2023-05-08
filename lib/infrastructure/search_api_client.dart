import 'dart:async';
import 'dart:convert';
import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:http/http.dart' as http;

class SearchApiClient {
  Future<SearchApiModelStruct>? getApiListInfo({
    required String input,
  }) async {
      final url =
          Uri.parse('https://api.github.com/search/repositories?q=$input');
      const timeOutCount = 5;
      final response =
          await http.get(url).timeout(const Duration(seconds: timeOutCount));
      final decoded = json.decode(response.body) as Map<String, dynamic>;
        final searchApiModelStruct = SearchApiModelStruct.fromJson(decoded);
      return searchApiModelStruct;
  }
}
