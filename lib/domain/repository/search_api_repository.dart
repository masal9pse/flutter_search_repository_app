import 'package:flutter_engineer_codecheck/domain/model/search_api_model.dart';
import 'package:flutter_engineer_codecheck/domain/types/error.dart';
import 'package:flutter_engineer_codecheck/domain/types/result.dart';

typedef ApiResults = Result<SearchApiModel,AppError>;

abstract class SearchApiRepository {
  Future<ApiResults> getApiListInfo({
    required String input,
  });
}
