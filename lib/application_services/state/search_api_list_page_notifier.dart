import 'package:flutter_engineer_codecheck/domain/model/app_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:http/http.dart' as http;
part 'search_api_list_page_notifier.g.dart';

@riverpod
class SearchApiListPageNotifier extends _$SearchApiListPageNotifier {
  @override
  AppState build() {
    return const Idle();
  }

  Future<void> search(String input) async {
    state = Loading();
    final url =
        Uri.parse('https://api.github.com/search/repositories?q=$input');
    const timeOutCount = 5;
    final response =
        await http.get(url).timeout(const Duration(seconds: timeOutCount));
    final decoded = json.decode(response.body) as Map<String, dynamic>;
    final searchApiModel = SearchApiModel.fromJson(decoded);
    state = Data(searchApiModel);
  }
}
