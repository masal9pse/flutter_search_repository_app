// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get errorTimeout => '通信がタイムアウトしました。時間をおいて再試行してください。';

  @override
  String get errorNetwork => 'ネットワークエラーが発生しました。通信環境を確認してください。';

  @override
  String get errorCanceled => 'リクエストがキャンセルされました。';

  @override
  String get errorUnauthorized => '認証に失敗しました。GitHub API の認証情報を確認してください。';

  @override
  String get errorRateLimit => 'GitHub API のレート制限に達しました。しばらく待ってから再試行してください。';

  @override
  String get errorNotFound => '検索 API が見つかりませんでした。時間をおいて再試行してください。';

  @override
  String get errorServer => 'GitHub 側でサーバーエラーが発生しました。時間をおいて再試行してください。';

  @override
  String errorHttp(int statusCode) {
    return '検索に失敗しました。(status: $statusCode)';
  }

  @override
  String get errorBadCertificate => '安全でない証明書が検出されたため、通信を中断しました。';

  @override
  String get errorInvalidResponse => 'レスポンスの形式が不正です。アプリを再起動して再試行してください。';

  @override
  String get errorUnknown => '不明なエラーが発生しました。時間をおいて再試行してください。';

  @override
  String get errorUnexpected => '想定外エラー';
}
