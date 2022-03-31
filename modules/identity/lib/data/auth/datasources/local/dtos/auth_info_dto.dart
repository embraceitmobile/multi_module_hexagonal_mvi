import 'package:core/core_pure_dart.dart';
import 'package:identity/domain/entities/auth_info.dart';

class AuthInfoDto extends AuthInfo implements SembastDto<int> {
  final int id;

  const AuthInfoDto({
    required this.id,
    required String accessToken,
    required String refreshToken,
  }) : super(
          userId: id,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );

  factory AuthInfoDto.fromDtoMap(Map<String, dynamic> map) => AuthInfoDto(
        id: map["userId"],
        accessToken: map["accessToken"],
        refreshToken: map["refreshToken"],
      );

  factory AuthInfoDto.fromAuthInfo(AuthInfo authInfo) => AuthInfoDto(
        id: authInfo.userId,
        accessToken: authInfo.accessToken,
        refreshToken: authInfo.refreshToken,
      );

  @override
  Map<String, dynamic> toDtoMap() => {
        "userId": userId,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };

  AuthInfoDto copyWith({
    int? userId,
    String? accessToken,
    String? refreshToken,
  }) =>
      AuthInfoDto(
        id: userId ?? this.userId,
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );
}
