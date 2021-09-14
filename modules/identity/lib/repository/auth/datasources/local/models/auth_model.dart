import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';

class AuthModel implements StateEntity {
  final int? userId;
  final String? accessToken;
  final String? refreshToken;

  final LocalState state;
  final String uniqueKey;

  const AuthModel({
    this.userId,
    this.accessToken,
    this.refreshToken,
    this.state = LocalState.success,
  }) : uniqueKey = "key";

  factory AuthModel.fromEntityMap(Map<String, dynamic> map) => AuthModel(
        userId: map["userId"],
        accessToken: map["accessToken"],
        refreshToken: map["refreshToken"],
        state: (map["state"] as int).toState,
      );

  factory AuthModel.fromAuthInfo(AuthInfo authInfo) => AuthModel(
        userId: authInfo.userId,
        accessToken: authInfo.accessToken,
        refreshToken: authInfo.refreshToken,
        state: LocalState.success,
      );

  factory AuthModel.loading() => AuthModel(state: LocalState.loading);

  factory AuthModel.failed() => AuthModel(state: LocalState.failed);

  @override
  Map<String, dynamic> toEntityMap() => {
        "userId": userId,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "state": state.toInt,
        Entity.unique_key: uniqueKey,
      };

  AuthInfo? get toAuthToken {
    switch (state) {
      case LocalState.success:
        return AuthInfo(
            userId: userId!,
            accessToken: accessToken!,
            refreshToken: refreshToken!);
      case LocalState.loading:
      case LocalState.failed:
        return null;
    }
  }

  AuthModel copyWith({
    int? userId,
    String? accessToken,
    String? refreshToken,
    LocalState? state,
  }) =>
      AuthModel(
        userId: userId ?? this.userId,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        state: state ?? this.state,
      );
}
