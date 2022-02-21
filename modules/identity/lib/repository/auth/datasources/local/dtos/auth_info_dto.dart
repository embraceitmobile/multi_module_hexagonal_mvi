import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';

class AuthInfoDto extends AuthInfo implements Dto {
  final String uniqueKey;

  const AuthInfoDto({
    required int userId,
    required String accessToken,
    required String refreshToken,
  })  : uniqueKey = "key",
        super(
          userId: userId,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory AuthInfoDto.fromDtoMap(Map<String, dynamic> map) => AuthInfoDto(
        userId: map["userId"],
        accessToken: map["accessToken"],
        refreshToken: map["refreshToken"],
      );

  factory AuthInfoDto.fromAuthInfo(AuthInfo authInfo) => AuthInfoDto(
        userId: authInfo.userId,
        accessToken: authInfo.accessToken,
        refreshToken: authInfo.refreshToken,
      );

  @override
  Map<String, dynamic> toDtoMap() => {
        "userId": userId,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        Dto.unique_key: uniqueKey,
      };

  AuthInfoDto copyWith({
    int? userId,
    String? accessToken,
    String? refreshToken,
  }) =>
      AuthInfoDto(
        userId: userId ?? this.userId,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );
}
