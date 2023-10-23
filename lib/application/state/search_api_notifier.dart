import 'package:flutter_engineer_codecheck/damain/entity/search_api_model.dart';
import 'package:flutter_engineer_codecheck/damain/types/error.dart';
import 'package:flutter_engineer_codecheck/damain/types/result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'search_api_notifier.g.dart';

@riverpod
class SearchApiNotifier extends _$SearchApiNotifier {
  @override
  Future<SearchApiModel?> build() async {
    return null;
  }

  Future<void> load() async {
    state = const AsyncValue.loading();
  }

  Future<void> updateState(Result<SearchApiModel, AppError> data) async {
    data.when(
      success: (value) {
        state = AsyncValue.data(value);
      },
      failure: (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
    );
  }
}
