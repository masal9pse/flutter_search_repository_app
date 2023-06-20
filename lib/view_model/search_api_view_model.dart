import 'dart:async';

import 'package:flutter_engineer_codecheck/di.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:flutter_state_notifier/flutter_state_notifier.dart';

class SearchApiViewModel extends StateNotifier<SearchApiModelStruct> with LocatorMixin {
  SearchApiViewModel():super(const SearchApiModelStruct(items: [], totalCount: 0));
  // SearchApiRepository get searchApiRepository => read<SearchApiRepositoryImpl>();

  /// API 通信 と View層への通知
  Future<void> fetchSearchApiModelStruct({required String text}) async {
    // getItでDI
    final response = await getIt<SearchApiRepository>().getApiListInfo(input: text);

    // final response = await searchApiRepository.getApiListInfo(input: text);
    state = state.copyWith(items: response!.items,totalCount: response.totalCount);
  }
}
