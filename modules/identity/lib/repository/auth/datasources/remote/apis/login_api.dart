import 'package:core/models/exceptions/invalid_data_exception.dart';

const loginEndpoint = "api/TokenAuth/Login";

class LoginRequest {
  final String userNameOrEmailAddress;
  final String password;
  final bool rememberClient;

  LoginRequest({
    required this.userNameOrEmailAddress,
    required this.password,
    this.rememberClient = true,
  });

  Map<String, dynamic> toMap() => {
        'userNameOrEmailAddress': userNameOrEmailAddress,
        'password': password,
        'rememberClient': rememberClient,
      };
}

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String encryptedAccessToken;
  final int expireInSeconds;
  final int userId;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.encryptedAccessToken,
    required this.expireInSeconds,
    required this.userId,
  });

  factory LoginResponse.fromMap(Map<String, dynamic> map) {
    if (map["accessToken"] == null &&
        map["refreshToken"] == null &&
        map["encryptedAccessToken"] == null &&
        map["expireInSeconds"] == null &&
        map["userId"] == null) {
      throw InvalidDataException("Invalid response received from server");
    }

    return LoginResponse(
      accessToken: map["accessToken"],
      refreshToken: map["refreshToken"],
      encryptedAccessToken: map["encryptedAccessToken"],
      expireInSeconds: map["expireInSeconds"],
      userId: map["userId"],
    );
  }

  @override
  String toString() {
    return 'LoginResponse{accessToken: $accessToken, refreshToken: $refreshToken, encryptedAccessToken: $encryptedAccessToken, expireInSeconds: $expireInSeconds, userId: $userId}';
  }
}
