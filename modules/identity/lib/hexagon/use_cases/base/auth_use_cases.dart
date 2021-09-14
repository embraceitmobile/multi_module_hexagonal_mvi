import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_state.dart';

abstract class AuthReader {
  Future<bool> get isLoggedIn;

  Future<String?> get accessToken;

  Future<String?> get refreshToken;
}

abstract class AuthListener {
  Stream<State<AuthState>> observeAuthState();
}

abstract class Authenticator {
  Future<bool> login(String email, String password);

  Future<bool> logoutActiveUser();

  Future<bool> changePassword(String currentPassword, String newPassword);
}
