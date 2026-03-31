import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/core/result.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_env.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_mock_data.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/search_repo_model.dart';

const _baseUrl = 'https://api.github.com';

/// GitHub Search Repositories API を呼び出すクライアント
class GithubRepoApi {
  GithubRepoApi({
    Dio? dio,
    bool? useMock,
  })  : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl)),
        _useMock = useMock ?? useMockGithubApi;

  final Dio _dio;
  final bool _useMock;

  /// リポジトリ詳細を取得する。
  Future<Result<Repo, GithubRepoApiException>> getRepository({
    required String owner,
    required String repo,
  }) async {
    if (_useMock) {
      return Success(
        data: GithubRepoMockData.repositoryDetail(owner: owner, repo: repo),
      );
    }
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/repos/$owner/$repo',
      );

      final data = response.data;
      if (data == null) {
        return const Failure(
          exception: InvalidResponseGithubRepoApiException(),
        );
      }

      final decoded = Repo.fromJson(data);
      return Success(data: decoded);
    } on DioException catch (e) {
      return Failure(exception: _mapDioException(e));
    } on FormatException {
      return const Failure(
        exception: InvalidResponseGithubRepoApiException(),
      );
    } on Exception {
      return const Failure(
        exception: UnknownGithubRepoApiException(),
      );
    }
  }

  /// リポジトリを検索する。
  Future<Result<RepoList, GithubRepoApiException>> searchRepositories({
    required String q,
  }) async {
    if (_useMock) {
      return const Success(data: GithubRepoMockData.searchResult);
    }
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/search/repositories',
        queryParameters: {'q': q},
      );

      final data = response.data;
      if (data == null) {
        return const Failure(
          exception: InvalidResponseGithubRepoApiException(),
        );
      }

      final decoded = RepoList.fromJson(data);
      return Success(data: decoded);
    } on DioException catch (e) {
      return Failure(exception: _mapDioException(e));
    } on FormatException {
      return const Failure(
        exception: InvalidResponseGithubRepoApiException(),
      );
    } on Exception {
      return const Failure(
        exception: UnknownGithubRepoApiException(),
      );
    }
  }

  GithubRepoApiException _mapDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const TimeoutGithubRepoApiException();
      case DioExceptionType.connectionError:
        return const NetworkGithubRepoApiException();
      case DioExceptionType.cancel:
        return const CanceledGithubRepoApiException();
      case DioExceptionType.badCertificate:
        return const BadCertificateGithubRepoApiException();
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode == 401) {
          return const UnauthorizedGithubRepoApiException();
        }
        if (statusCode == 403) {
          return const RateLimitGithubRepoApiException();
        }
        if (statusCode == 404) {
          return const NotFoundGithubRepoApiException();
        }
        if (statusCode != null && statusCode >= 500) {
          return const ServerGithubRepoApiException();
        }
        return HttpGithubRepoApiException(statusCode: statusCode);
      case DioExceptionType.unknown:
        return const UnknownGithubRepoApiException();
    }
  }
}
