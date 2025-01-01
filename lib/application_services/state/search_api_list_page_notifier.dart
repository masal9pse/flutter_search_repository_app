import 'package:flutter_engineer_codecheck/application_services/di/infrastructure.dart';
import 'package:flutter_engineer_codecheck/domain/model/app_state.dart';
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
    final datas = await ref
        .read(searchApiRepositoryProvider)
        .getApiListInfo(input: input);
    datas.when(
      success: (data) {
        state = Data(data);
      },
      failure: (error) {
        state = Error(error);
      },
    );
  }
}