// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get topAppBarTitle => 'Github検索アプリ';

  @override
  String get showAppBarTitle => '詳細ページ';

  @override
  String get connectionTimeoutError => '接続がタイムアウトしました。ネットワーク接続を確認してください。';

  @override
  String get sendTimeoutError => 'データ送信中にタイムアウトしました。後でもう一度お試しください。';

  @override
  String get receiveTimeoutError => 'レスポンスがタイムアウトしました。サーバーを確認するか、後で再試行してください。';

  @override
  String get badCertificateError => '無効なサーバー証明書です。接続を確立できません。';

  @override
  String get badResponseError => '無効なサーバーレスポンスを受信しました。サポートにお問い合わせください。';

  @override
  String get cancelError => 'リクエストがキャンセルされました。必要に応じて再試行してください。';

  @override
  String get connectionError => '接続エラーが発生しました。ネットワークを確認してください。';

  @override
  String get unknownError => '未知のエラーが発生しました。後でもう一度お試しください。';
}
