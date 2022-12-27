import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'result.freezed.dart';

@freezed
abstract class Result<T, E> with _$Result<T, E> {
  const factory Result.success(T value) = Success<T, E>;

  const factory Result.failure(E error) = Failure<T, E>;
}