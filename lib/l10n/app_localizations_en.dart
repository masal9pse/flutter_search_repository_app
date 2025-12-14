// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get topAppBarTitle => 'Github Search App';

  @override
  String get showAppBarTitle => 'Detail Page';

  @override
  String get connectionTimeoutError =>
      'Connection timeout. Please check your network connection.';

  @override
  String get sendTimeoutError =>
      'Request timeout while sending data. Please try again later.';

  @override
  String get receiveTimeoutError =>
      'Response timeout. Please check the server or try again later.';

  @override
  String get badCertificateError =>
      'Invalid server certificate. Connection cannot be established.';

  @override
  String get badResponseError =>
      'Received invalid server response. Please contact support.';

  @override
  String get cancelError =>
      'Request was cancelled. Please try again if needed.';

  @override
  String get connectionError =>
      'Connection error occurred. Please check your network.';

  @override
  String get unknownError =>
      'An unknown error occurred. Please try again later.';
}
