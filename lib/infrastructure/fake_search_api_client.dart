import 'package:flutter_engineer_codecheck/damain/entity/search_api_struct.dart';
import 'package:flutter_engineer_codecheck/damain/repository/search_api_repository.dart';
import 'package:flutter_engineer_codecheck/damain/types/error.dart';
import 'package:flutter_engineer_codecheck/damain/types/result.dart';
import 'package:flutter_engineer_codecheck/infrastructure/test_data/api_mock_test_data.dart';

class FakeSearchApiRepositoryImpl implements SearchApiRepository {
  @override
  Future<Result<SearchApiModelStruct,AppError>> getApiListInfo({
    required String input,
  }) {
    final apiSuccessTestData01 = ApiMockTestData().apiSuccessTestData01;
    final convertedApiSuccessTestData01 =
        SearchApiModelStruct.fromJson(apiSuccessTestData01);
    return Future.value(Result.success(convertedApiSuccessTestData01));
  }
}

class FakeErrorSearchApiRepositoryImpl implements SearchApiRepository {
  @override
  Future<Result<SearchApiModelStruct,AppError>> getApiListInfo({
    required String input,
  }) {
      return Future.value(const Result.failure(AppError.fetchError()));
  }
}