import 'package:flutter_engineer_codecheck/infrastructure/search_api_service.dart';
import 'package:flutter_engineer_codecheck/model/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/repository/search_api_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_api_notifier.g.dart';

@riverpod
class SearchApiNotifier extends _$SearchApiNotifier {

  final repository = SearchApiRepositoryImpl(searchApiClient: SearchApiClient());  
  @override
  Future<SearchApiModelStruct?> build() async {
    return null;
  }

  // 状態を変更したときにisRefreshingをtrueにする
  Future<void> updateState(String input) async {
    state = const AsyncValue.loading();
    // state = AsyncData(await repository.getApiListInfo(input: input));
    final data = await repository.getApiListInfo(input: input);
    state = AsyncValue.data(data);
    
    final k = 3;
  }
}
