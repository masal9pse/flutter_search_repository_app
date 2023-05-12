import 'package:freezed_annotation/freezed_annotation.dart';

part 'error.freezed.dart';

@freezed
abstract class AppError with _$AppError {
  const AppError._();

  const factory AppError.fetchError() = _FetchError;

  String get message => when(
        fetchError: () => Strings.fetchError,
      );
}

class Strings {
  static const fetchError = 'データの取得に失敗しました。';
}