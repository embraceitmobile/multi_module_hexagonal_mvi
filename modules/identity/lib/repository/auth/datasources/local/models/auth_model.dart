import 'package:core/core.dart';
import 'package:identity_module/hexagon/entities/auth_token.dart';

class AuthModel implements AuthToken, StateEntity {
  final String accessToken;
  final String refreshToken;
  final LocalState state;

  String get uniqueKey => "key";

  const AuthModel({
    required this.accessToken,
    required this.refreshToken,
    this.state = LocalState.success,
  });

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

  factory AuthModel.loading() => AuthModel(
        accessToken: "",
        refreshToken: "",
        state: LocalState.loading,
      );

  factory AuthModel.failed() => AuthModel(
        accessToken: "",
        refreshToken: "",
        state: LocalState.failed,
      );

  @override
  Map<String, dynamic> toEntityMap() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "state": state.toInt,
      };

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
