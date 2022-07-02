import 'dart:convert';

ApiError apiErrorFromJson(String str) => ApiError.fromJson(json.decode(str));

String apiErrorToJson(ApiError data) => json.encode(data.toJson());

class ApiError {
  ApiError({
    required this.code,
    required this.message,
  });

  final int? code;
  final String? message;

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        code: json['code'],
        message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'message': message,
      };
}
