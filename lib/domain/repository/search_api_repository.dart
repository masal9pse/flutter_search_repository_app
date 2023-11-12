import 'package:flutter_engineer_codecheck/domain/model/error.dart';
import 'package:flutter_engineer_codecheck/domain/model/result.dart';
import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';

typedef ApiResults = Result<SearchApiModel,AppError>;

abstract class SearchApiRepository {
  Future<ApiResults> getApiListInfo({
    required String input,
  });
}
