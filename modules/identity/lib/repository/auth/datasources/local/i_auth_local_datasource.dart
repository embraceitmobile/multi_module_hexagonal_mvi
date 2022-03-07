import 'package:identity/repository/auth/datasources/local/dtos/auth_info_dto.dart';

abstract class IAuthLocalDatasource {
  Future<AuthInfoDto?> get auth;

  Future<bool> hasAuth();

  Future<void> saveAuth(AuthInfoDto auth);

  Future<void> removeAuth();

  Future<void> updateAuth(AuthInfoDto auth);

  Stream<AuthInfoDto?> observeAuth();
}
