import 'package:core/core.dart';
import 'package:identity/domain/entities/auth_info.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<AuthInfo?> get authInfo;

  Future<void> saveAuthInfo(AuthInfo authToken);

  Stream<DataState<AuthInfo>> observeAuthInfo();

  Future<bool> login(String email, String password);

  Future<void> logoutUser({bool isForceLogout = false});

  Future<bool> changePassword(String currentPassword, String newPassword);
}
