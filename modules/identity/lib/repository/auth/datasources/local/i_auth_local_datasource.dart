import 'package:identity/repository/auth/datasources/local/models/auth_info_dto.dart';

abstract class IAuthLocalDatasource {
  Future<AuthInfoDto?> get auth;

  Future<bool> hasAuth();

  Future<int> saveAuth(AuthInfoDto auth);

  Future<bool> removeAuth();

  Future<bool> updateAuth(AuthInfoDto auth);

  Stream<AuthInfoDto?> observeAuth();
}
