import 'package:core/core.dart';

class AuthModel implements Entity {
  final String accessToken;
  final String refreshToken;

  String get uniqueKey => "key";

  const AuthModel({required this.accessToken, required this.refreshToken});

  factory AuthModel.fromEntityMap(Map<String, dynamic> map) => AuthModel(
        accessToken: map["accessToken"],
        refreshToken: map["refreshToken"],
      );

  @override
  Map<String, dynamic> toEntityMap() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };

  AuthModel copyWith({String? accessToken, String? refreshToken}) => AuthModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );
}
