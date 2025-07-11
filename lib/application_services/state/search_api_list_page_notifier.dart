import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_engineer_codecheck/domain/model/app_state.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_github_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:async';
part 'search_api_list_page_notifier.g.dart';

@riverpod
class SearchApiListPageNotifier extends _$SearchApiListPageNotifier {
  @override
  AppState build() {
    return const Idle();
  }

  Future<void> search(String input) async {
    state = Loading();
    final dio = Dio();
    final apiToken = dotenv.env['GITHUB_TOKEN'] ?? '';
    if (apiToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $apiToken';
    }
    final client = SearchGithubRepository(dio);
    client.getApiListInfo(input).then((value) {
      state = Data(value);
    }).catchError((error) {
      state = Error(error);
    });
  }

  Future<void> loadMore(String input) async {
    if (state is! Data) {
      return;
    }
    final previous = state as Data;
    state = AddLoading(previous.searchApiModel);
    final dio = Dio();
    final apiToken = dotenv.env['GITHUB_TOKEN'] ?? '';
    if (apiToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $apiToken';
    }
    final client = SearchGithubRepository(dio);
    client.getApiListInfo(input).then((value) {
      state = Data(
        SearchApiModel(
            items: [...previous.searchApiModel.items, ...value.items]),
      );
    }).catchError((error) {
      state = Error(error);
    });
  }
}
