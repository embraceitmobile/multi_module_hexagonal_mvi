import 'package:core/models/network/base_response.dart';
import 'package:dio/dio.dart';

class NetworkException implements Exception {
  final ErrorResponse error;

  NetworkException(this.error);

  factory NetworkException.fromException(Exception exception) {
    if (exception is DioError) {
      return NetworkException(_handleDioError(exception));
    }

    return NetworkException(ErrorResponse(
        message: "Unknown network error happened",
        details: exception.toString()));
  }

  static ErrorResponse _handleDioError(DioError error) {
    final defaultError = ErrorResponse(
        statusCode: 500,
        message: "Error received from server",
        details: "Error details not provided by server");

    switch (error.type) {
      case DioErrorType.cancel:
        return ErrorResponse(message: "Request to API server was cancelled");
      case DioErrorType.connectTimeout:
        return ErrorResponse(
            statusCode: 408,
            message:
                "Unable to connect with server, please check your internet connectivity",
            details: "Timeout occurred");
      case DioErrorType.other:
        return ErrorResponse(
            message:
                "Unable to connect with server, please check your internet connectivity",
            details: "Unknown network error");
      case DioErrorType.receiveTimeout:
        return ErrorResponse(
            message: "Receive timeout in connection with API server",
            details: "Receive Timeout occurred");
      case DioErrorType.response:
        final res = error.response?.data ?? "";
        if (res is String && res.isEmpty) return defaultError;

        final response = res is String
            ? BaseResponse.fromJson(res)
            : BaseResponse.fromMap(res);
        return response.error!;
      case DioErrorType.sendTimeout:
        return ErrorResponse(
            message: "Send timeout in connection with API server",
            details: "Send Timeout occurred");
      default:
        return defaultError;
    }
  }
}
