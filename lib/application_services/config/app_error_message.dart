import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String createErrorMessage(Object error, BuildContext context) {
  final appLocalizations = AppLocalizations.of(context)!;

  if (error is DioException) {
    switch(error.type) {
      case DioExceptionType.connectionTimeout:
        return appLocalizations.connectionTimeoutError;
      case DioExceptionType.sendTimeout:
        return appLocalizations.sendTimeoutError;
      case DioExceptionType.receiveTimeout:
        return appLocalizations.receiveTimeoutError;
      case DioExceptionType.badCertificate:
        return appLocalizations.badCertificateError;
      case DioExceptionType.badResponse:
        return appLocalizations.badResponseError;
      case DioExceptionType.cancel:
        return appLocalizations.cancelError;
      case DioExceptionType.connectionError:
        return appLocalizations.connectionError;
      case DioExceptionType.unknown:
        return appLocalizations.unknownError;
    }
  }
  return appLocalizations.unknownError;
}
