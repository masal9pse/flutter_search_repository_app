// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorTimeout => 'Request timed out. Please try again later.';

  @override
  String get errorNetwork =>
      'A network error occurred. Please check your connection.';

  @override
  String get errorCanceled => 'The request was canceled.';

  @override
  String get errorUnauthorized =>
      'Authentication failed. Please check your GitHub API credentials.';

  @override
  String get errorRateLimit =>
      'GitHub API rate limit exceeded. Please try again later.';

  @override
  String get errorNotFound => 'Search API not found. Please try again later.';

  @override
  String get errorServer =>
      'A server error occurred on GitHub. Please try again later.';

  @override
  String errorHttp(int statusCode) {
    return 'Search failed. (status: $statusCode)';
  }

  @override
  String get errorBadCertificate =>
      'Connection aborted due to an insecure certificate.';

  @override
  String get errorInvalidResponse =>
      'Invalid response format. Please restart the app and try again.';

  @override
  String get errorUnknown =>
      'An unknown error occurred. Please try again later.';

  @override
  String get errorUnexpected => 'Unexpected error';
}
