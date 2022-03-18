import 'package:core/models/exceptions/invalid_data_exception.dart';
import 'package:identity/domain/entities/auth_info.dart';

const loginEndpoint = "/users";

class LoginRequest {
  final String username;
  final String password;

  LoginRequest({
    required this.username,
    required this.password,
  });
}

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final int expireInSeconds;
  final int userId;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.expireInSeconds,
    required this.userId,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    if (map["accessToken"] == null &&
        map["refreshToken"] == null &&
        map["expireInSeconds"] == null &&
        map["userId"] == null) {
      throw InvalidDataException("Invalid response received from server");
    }

    return LoginResponse(
      accessToken: map["accessToken"],
      refreshToken: map["refreshToken"],
      expireInSeconds: map["expireInSeconds"],
      userId: map["userId"],
    );
  }

  AuthInfo get toAuthInfo => AuthInfo(
        accessToken: accessToken,
        refreshToken: refreshToken,
        userId: userId,
      );

  @override
  String toString() {
    return 'LoginResponse{accessToken: $accessToken, refreshToken: $refreshToken, expireInSeconds: $expireInSeconds, userId: $userId}';
  }
}
