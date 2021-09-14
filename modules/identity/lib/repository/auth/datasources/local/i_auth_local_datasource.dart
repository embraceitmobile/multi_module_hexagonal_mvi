import 'package:identity/repository/auth/datasources/local/models/auth_model.dart';

abstract class IAuthLocalDatasource {
  Future<AuthModel?> get auth;

  Future<bool> hasAuth();

  Future<int> saveAuth(AuthModel auth);

  Future<bool> removeAuth();

  Future<bool> updateAuth(AuthModel auth);

  Stream<AuthModel?> observeAuth();
}
