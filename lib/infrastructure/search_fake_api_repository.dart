import 'package:flutter_engineer_codecheck/domain/model/result.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/infrastructure/search_github_api_repository.dart';

class SearchFakeApiRepository implements SearchApiRepository {
  @override
  Future<ApiResults> getApiListInfo({
    required String input,
  }) async {
    return Future.value(const Result.success(SearchApiModel.mockData));
  }
}

class SearchFakeErrorApiRepository implements SearchApiRepository {
  @override
  Future<ApiResults> getApiListInfo({
    required String input,
  }) {
    return Future.value(Result.failure(Exception()));
  }
}
