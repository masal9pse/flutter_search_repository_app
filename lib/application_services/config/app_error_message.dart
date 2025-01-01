import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String createErrorMessage(Object error, BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;

  if (error is Exception) {
    if (error is FormatException) {
      return appLocalizations.invalidFormatError;
    }
    if (error is TimeoutException) {
      return appLocalizations.timeoutError;
    }
    if (error is SocketException) {
      return appLocalizations.networkError;
    }
    if (error is HttpException) {
      return appLocalizations.httpError;
    }
    if (error is PlatformException) {
      return appLocalizations.httpError;
    }
  }
  return appLocalizations.unknownError;
}
