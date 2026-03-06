sealed class GithubRepoApiException implements Exception {
  const GithubRepoApiException(this.message);

  final String message;

  @override
  String toString() => message;
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
