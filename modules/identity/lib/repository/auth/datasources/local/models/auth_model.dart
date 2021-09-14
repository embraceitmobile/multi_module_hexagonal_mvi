import 'package:core/core.dart';
import 'package:identity_module/hexagon/entities/auth_token.dart';

class AuthModel implements StateEntity {
  final String? accessToken;
  final String? refreshToken;
  final LocalState state;
  final String uniqueKey;

  const AuthModel({
    this.accessToken,
    this.refreshToken,
    this.state = LocalState.success,
  }) : uniqueKey = "key";

  factory AuthModel.fromEntityMap(Map<String, dynamic> map) => AuthModel(
        accessToken: map["accessToken"],
        refreshToken: map["refreshToken"],
        state: (map["state"] as int).toState,
      );

  factory AuthModel.fromAuthToken(AuthToken authToken) => AuthModel(
        accessToken: authToken.accessToken,
        refreshToken: authToken.refreshToken,
        state: LocalState.success,
      );

  factory AuthModel.loading() => AuthModel(state: LocalState.loading);

  factory AuthModel.failed() => AuthModel(state: LocalState.failed);

  @override
  Map<String, dynamic> toEntityMap() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "state": state.toInt,
        Entity.unique_key: uniqueKey,
      };

  AuthToken? get toAuthToken {
    if (accessToken == null || refreshToken == null) return null;
    return AuthToken(accessToken: accessToken!, refreshToken: refreshToken!);
  }

  AuthModel copyWith({
    String? accessToken,
    String? refreshToken,
    LocalState? state,
  }) =>
      AuthModel(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
        state: state ?? this.state,
      );
}
