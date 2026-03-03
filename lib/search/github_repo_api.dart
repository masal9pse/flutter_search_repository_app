import 'package:dio/dio.dart';

import 'search_repo_model.dart';

const _baseUrl = 'https://api.github.com';

/// GitHub Search Repositories API を呼び出すクライアント
class GithubRepoApi {
  GithubRepoApi({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  final Dio _dio;

  /// リポジトリを検索する。q が空の場合は "Q" で検索する。
  Future<SearchApiModel> searchRepositories({String q = 'Q'}) async {
    final query = q.trim().isEmpty ? 'Q' : q.trim();
    final response = await _dio.get<Map<String, dynamic>>(
      '/search/repositories',
      queryParameters: {'q': query},
    );
    if (response.data == null) {
      throw Exception('No data');
    }
    return SearchApiModel.fromJson(response.data!);
  }
}
