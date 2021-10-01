import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<AuthInfo?> get authInfo;

  Future<bool> saveAuthInfo(AuthInfo authToken);

  Stream<DataState<AuthInfo>> observeAuthInfo();

  Future<bool> login(String email, String password);

  Future<bool> logoutActiveUser({bool isForceLogout = false});

  Future<bool> changePassword(String currentPassword, String newPassword);
}
