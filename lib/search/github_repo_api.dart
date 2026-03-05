import 'package:dio/dio.dart';
import 'package:flutter_engineer_codecheck/search/search_repo_model.dart';

const _baseUrl = 'https://api.github.com';

sealed class Result<T> {
  const Result();
}

final class Success<T> extends Result<T> {
  const Success({required this.data});

  final T data;
}

final class Error<T> extends Result<T> {
  const Error({required this.exception});

  final GithubRepoApiException exception;
}

sealed class GithubRepoApiException implements Exception {
  const GithubRepoApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

final class EmptyResponseException extends GithubRepoApiException {
  const EmptyResponseException() : super('サーバーからのレスポンスが空でした。');
}

final class TimeoutGithubRepoApiException extends GithubRepoApiException {
  const TimeoutGithubRepoApiException()
      : super('通信がタイムアウトしました。時間をおいて再試行してください。');
}

final class NetworkGithubRepoApiException extends GithubRepoApiException {
  const NetworkGithubRepoApiException()
      : super('ネットワークエラーが発生しました。通信環境を確認してください。');
}

final class CanceledGithubRepoApiException extends GithubRepoApiException {
  const CanceledGithubRepoApiException() : super('リクエストがキャンセルされました。');
}

final class UnauthorizedGithubRepoApiException extends GithubRepoApiException {
  const UnauthorizedGithubRepoApiException()
      : super('認証に失敗しました。GitHub API の認証情報を確認してください。');
}

final class RateLimitGithubRepoApiException extends GithubRepoApiException {
  const RateLimitGithubRepoApiException()
      : super('GitHub API のレート制限に達しました。しばらく待ってから再試行してください。');
}

final class NotFoundGithubRepoApiException extends GithubRepoApiException {
  const NotFoundGithubRepoApiException()
      : super('検索 API が見つかりませんでした。時間をおいて再試行してください。');
}

final class ServerGithubRepoApiException extends GithubRepoApiException {
  const ServerGithubRepoApiException()
      : super('GitHub 側でサーバーエラーが発生しました。時間をおいて再試行してください。');
}

final class HttpGithubRepoApiException extends GithubRepoApiException {
  const HttpGithubRepoApiException({required this.statusCode})
      : super('検索に失敗しました。(status: $statusCode)');

  final int? statusCode;
}

final class BadCertificateGithubRepoApiException
    extends GithubRepoApiException {
  const BadCertificateGithubRepoApiException()
      : super('安全でない証明書が検出されたため、通信を中断しました。');
}

final class InvalidResponseGithubRepoApiException
    extends GithubRepoApiException {
  const InvalidResponseGithubRepoApiException()
      : super('レスポンスの形式が不正です。アプリを再起動して再試行してください。');
}

final class UnknownGithubRepoApiException extends GithubRepoApiException {
  const UnknownGithubRepoApiException()
      : super('不明なエラーが発生しました。時間をおいて再試行してください。');
}

/// GitHub Search Repositories API を呼び出すクライアント
class GithubRepoApi {
  GithubRepoApi({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(baseUrl: _baseUrl));

  final Dio _dio;

  /// リポジトリを検索する。q が空の場合は "Q" で検索する。
  Future<Result<SearchApiModel>> searchRepositories({required String q}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/search/repositories',
        queryParameters: {'q': q},
      );

      return Success<SearchApiModel>(
        data: SearchApiModel.fromJson(response.data!),
      );
    } on DioException catch (e) {
      return Error<SearchApiModel>(exception: _mapDioException(e));
    } on FormatException {
      return const Error<SearchApiModel>(
        exception: InvalidResponseGithubRepoApiException(),
      );
    } on Exception {
      return const Error<SearchApiModel>(
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
