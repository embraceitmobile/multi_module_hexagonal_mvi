import 'package:core/core.dart';
import 'package:identity/domain/entities/auth_info.dart';
import 'package:identity/domain/entities/auth_state.dart';

abstract class AuthReader {
  Future<bool> get isAuthenticated;

  Future<AuthInfo?> get authInfo;
}

abstract class AuthListener {
  Stream<DataState<AuthState>> observeAuthState();
}

abstract class AuthActions {
  Future<bool> login(String email, String password);

  Future<bool> logoutUser({bool isForceLogout = false});

  Future<bool> changePassword(String currentPassword, String newPassword);
}
