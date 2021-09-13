import 'dart:convert';

import 'package:core/models/exceptions/invalid_data_exception.dart';

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final String encryptedAccessToken;
  final int expireInSeconds;
  final int userId;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.encryptedAccessToken,
    required this.expireInSeconds,
    required this.userId,
  });

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    if (map["accessToken"] == null &&
        map["refreshToken"] == null &&
        map["encryptedAccessToken"] == null &&
        map["expireInSeconds"] == null &&
        map["userId"] == null) {
      throw InvalidDataException("Invalid response received froms server");
    }

    return AuthResponse(
      accessToken: map["accessToken"],
      refreshToken: map["refreshToken"],
      encryptedAccessToken: map["encryptedAccessToken"],
      expireInSeconds: map["expireInSeconds"],
      userId: map["userId"],
    );
  }

  factory AuthResponse.empty() => AuthResponse(
        accessToken: "",
        refreshToken: "",
        encryptedAccessToken: "",
        expireInSeconds: 0,
        userId: 0,
      );

  factory AuthResponse.fromJson(String str) {
    if (str == null || str.isEmpty) {
      throw InvalidDataException("Invalid response received from server");
    }

    return AuthResponse.fromMap(json.decode(str));
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "encryptedAccessToken": encryptedAccessToken,
        "expireInSeconds": expireInSeconds,
        "userId": userId,
      };

  bool get isEmpty => userId == 0;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthResponse &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          refreshToken == other.refreshToken &&
          encryptedAccessToken == other.encryptedAccessToken &&
          expireInSeconds == other.expireInSeconds &&
          userId == other.userId;

  @override
  int get hashCode =>
      accessToken.hashCode ^
      refreshToken.hashCode ^
      encryptedAccessToken.hashCode ^
      expireInSeconds.hashCode ^
      userId.hashCode;

  @override
  String toString() {
    return 'AuthResponse{accessToken: $accessToken, refreshToken: $refreshToken, encryptedAccessToken: $encryptedAccessToken, expireInSeconds: $expireInSeconds, userId: $userId}';
  }
}
