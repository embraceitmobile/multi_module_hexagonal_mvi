import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';
import 'package:identity/hexagon/entities/auth_state.dart';

abstract class AuthReader {
  Future<bool> get isAuthenticated;

  Future<AuthInfo?> get authInfo;
}

abstract class AuthListener {
  Stream<DataState<AuthState>> observeAuthState();
}

abstract class AuthActions {
  Future<bool> login({required String email, required String password});

  Future<bool> logoutActiveUser({bool isForceLogout = false});

  Future<bool> changePassword(String currentPassword, String newPassword);
}
