sealed class GithubRepoApiException implements Exception {
  const GithubRepoApiException();

  @override
  String toString() => 'GithubRepoApiException';
}

final class TimeoutGithubRepoApiException extends GithubRepoApiException {
  const TimeoutGithubRepoApiException();
}

final class NetworkGithubRepoApiException extends GithubRepoApiException {
  const NetworkGithubRepoApiException();
}

final class CanceledGithubRepoApiException extends GithubRepoApiException {
  const CanceledGithubRepoApiException();
}

final class UnauthorizedGithubRepoApiException extends GithubRepoApiException {
  const UnauthorizedGithubRepoApiException();
}

final class RateLimitGithubRepoApiException extends GithubRepoApiException {
  const RateLimitGithubRepoApiException();
}

final class NotFoundGithubRepoApiException extends GithubRepoApiException {
  const NotFoundGithubRepoApiException();
}

final class ServerGithubRepoApiException extends GithubRepoApiException {
  const ServerGithubRepoApiException();
}

final class HttpGithubRepoApiException extends GithubRepoApiException {
  const HttpGithubRepoApiException({required this.statusCode});

  final int? statusCode;
}

final class BadCertificateGithubRepoApiException
    extends GithubRepoApiException {
  const BadCertificateGithubRepoApiException();
}

final class InvalidResponseGithubRepoApiException
    extends GithubRepoApiException {
  const InvalidResponseGithubRepoApiException();
}

final class UnknownGithubRepoApiException extends GithubRepoApiException {
  const UnknownGithubRepoApiException();
}
