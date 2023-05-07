import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_api_notifier.g.dart';

@riverpod
class SearchApiNotifier extends _$SearchApiNotifier {
  @override
  Future<SearchApiModelStruct?> build() async {
    return null;
  }

  Future<void> updateState(String input) async {
    state = const AsyncValue.loading();
      final repository = ref.watch(searchApiRepositoryProvider);
      state = await AsyncValue.guard(() async {
        final data = await repository.getApiListInfo(input: input);
        return data;
      });
  }
}
