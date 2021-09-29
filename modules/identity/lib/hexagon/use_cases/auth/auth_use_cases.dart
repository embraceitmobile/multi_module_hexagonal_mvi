import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';

abstract class AuthReader {
  Future<bool> get isAuthenticated;

  Future<AuthInfo?> get authInfo;
}

abstract class AuthListener {
  Stream<DataState<AuthInfo>> observeAuthState();
}

abstract class AuthActions {
  Future<bool> login(String email, String password);

  Future<bool> logoutActiveUser({bool isForceLogout = false});

  Future<bool> changePassword(String currentPassword, String newPassword);
}
