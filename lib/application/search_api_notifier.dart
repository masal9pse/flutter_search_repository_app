import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_api_notifier.g.dart';

@riverpod
class SearchApiNotifier extends _$SearchApiNotifier {
  @override
  Future<SearchApiModelStruct?> build() async {
    return null;
  }

  // 状態を変更したときにisRefreshingをtrueにする
  Future<void> updateState(String input) async {
    try {
      state = const AsyncValue.loading();
      final repository = ref.watch(searchApiRepositoryProvider);
      final data = await repository.getApiListInfo(input: input);
      state = AsyncValue.data(data);
    } catch (e,stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
