import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @errorTimeout.
  ///
  /// In ja, this message translates to:
  /// **'通信がタイムアウトしました。時間をおいて再試行してください。'**
  String get errorTimeout;

  /// No description provided for @errorNetwork.
  ///
  /// In ja, this message translates to:
  /// **'ネットワークエラーが発生しました。通信環境を確認してください。'**
  String get errorNetwork;

  /// No description provided for @errorCanceled.
  ///
  /// In ja, this message translates to:
  /// **'リクエストがキャンセルされました。'**
  String get errorCanceled;

  /// No description provided for @errorUnauthorized.
  ///
  /// In ja, this message translates to:
  /// **'認証に失敗しました。GitHub API の認証情報を確認してください。'**
  String get errorUnauthorized;

  /// No description provided for @errorRateLimit.
  ///
  /// In ja, this message translates to:
  /// **'GitHub API のレート制限に達しました。しばらく待ってから再試行してください。'**
  String get errorRateLimit;

  /// No description provided for @errorNotFound.
  ///
  /// In ja, this message translates to:
  /// **'検索 API が見つかりませんでした。時間をおいて再試行してください。'**
  String get errorNotFound;

  /// No description provided for @errorServer.
  ///
  /// In ja, this message translates to:
  /// **'GitHub 側でサーバーエラーが発生しました。時間をおいて再試行してください。'**
  String get errorServer;

  /// No description provided for @errorHttp.
  ///
  /// In ja, this message translates to:
  /// **'検索に失敗しました。(status: {statusCode})'**
  String errorHttp(int statusCode);

  /// No description provided for @errorBadCertificate.
  ///
  /// In ja, this message translates to:
  /// **'安全でない証明書が検出されたため、通信を中断しました。'**
  String get errorBadCertificate;

  /// No description provided for @errorInvalidResponse.
  ///
  /// In ja, this message translates to:
  /// **'レスポンスの形式が不正です。アプリを再起動して再試行してください。'**
  String get errorInvalidResponse;

  /// No description provided for @errorUnknown.
  ///
  /// In ja, this message translates to:
  /// **'不明なエラーが発生しました。時間をおいて再試行してください。'**
  String get errorUnknown;

  /// No description provided for @errorUnexpected.
  ///
  /// In ja, this message translates to:
  /// **'想定外エラー'**
  String get errorUnexpected;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
