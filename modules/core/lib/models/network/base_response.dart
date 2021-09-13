import 'dart:convert';

import 'package:core/models/exceptions/invalid_data_exception.dart';
import 'package:core/models/exceptions/network_exception.dart';

class BaseResponse {
  final dynamic result;
  final bool? success;
  final ErrorResponse? error;

  BaseResponse(this.result, this.success, this.error);

  factory BaseResponse.fromJson(String str) => BaseResponse.fromMap(json.decode(
      str.replaceAll('\\', '').replaceAll('"[', '[').replaceAll(']"', ']')));

  factory BaseResponse.fromMap(Map<String, dynamic> json) {
    if (json["result"] == null &&
        json["success"] == null &&
        json["error"] == null) {
      throw InvalidDataException("Invalid response received from server");
    }

    if (json["success"] == true &&
        json["result"] == null &&
        json["error"] != null) {
      throw NetworkException(ErrorResponse.fromMap(json["error"]));
    }

    final res = BaseResponse(
      json["result"] == null ? null : json["result"],
      json["success"],
      json["error"] == null ? null : ErrorResponse.fromMap(json["error"]),
    );

    return res;
  }

  @override
  String toString() {
    return 'BaseResponse{result: $result, success: $success, error: $error}';
  }
}

class ErrorResponse {
  final int? statusCode;
  final String message;
  final List<ValidationError>? validationErrors;
  final String? details;

  ErrorResponse({
    this.statusCode,
    required this.message,
    this.details,
    this.validationErrors,
  });

  factory ErrorResponse.fromMap(Map<String, dynamic> json) => ErrorResponse(
        statusCode: json["code"],
        message: json["message"],
        details: json["details"],
        validationErrors: json["validationErrors"] == null
            ? null
            : List<ValidationError>.from(json["validationErrors"]
                .map((x) => ValidationError.fromMap(x))),
      );
}

class ValidationError {
  final String message;
  final List<String> members;

  ValidationError(this.message, this.members);

  factory ValidationError.fromMap(Map<String, dynamic> json) => ValidationError(
        json["message"],
        List<String>.from(json["members"].map((x) => x)),
      );
}
