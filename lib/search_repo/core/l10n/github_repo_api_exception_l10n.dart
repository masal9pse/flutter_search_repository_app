import 'package:flutter/material.dart';
import 'package:flutter_engineer_codecheck/l10n/app_localizations.dart';
import 'package:flutter_engineer_codecheck/search_repo/repository/github_repo_api_exception.dart';

extension GithubRepoApiExceptionL10n on GithubRepoApiException {
  String localizedMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      TimeoutGithubRepoApiException() => l10n.errorTimeout,
      NetworkGithubRepoApiException() => l10n.errorNetwork,
      CanceledGithubRepoApiException() => l10n.errorCanceled,
      UnauthorizedGithubRepoApiException() => l10n.errorUnauthorized,
      RateLimitGithubRepoApiException() => l10n.errorRateLimit,
      NotFoundGithubRepoApiException() => l10n.errorNotFound,
      ServerGithubRepoApiException() => l10n.errorServer,
      HttpGithubRepoApiException(:final statusCode) =>
        l10n.errorHttp(statusCode ?? 0),
      BadCertificateGithubRepoApiException() => l10n.errorBadCertificate,
      InvalidResponseGithubRepoApiException() => l10n.errorInvalidResponse,
      UnknownGithubRepoApiException() => l10n.errorUnknown,
    };
  }
}
