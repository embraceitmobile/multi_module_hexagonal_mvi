import 'package:identity_module/repository/auth/datasources/local/models/auth_model.dart';

abstract class IAuthLocalDatasource {
  Future<bool> hasAuth();

  Future<int> saveAuth(AuthModel auth);

  Future<bool> removeAuth();

  Future<bool> updateAuth(AuthModel auth);

  Stream<AuthModel?> observeAuth();
}
