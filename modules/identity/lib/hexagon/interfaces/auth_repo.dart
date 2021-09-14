import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';
import 'package:identity/hexagon/entities/auth_state.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<AuthInfo?> get authToken;

  Future<bool> saveAuthToken(AuthInfo authToken);

  Stream<State<AuthState>> observeAuthState();

  Future<bool> login(String email, String password);

  Future<bool> logoutActiveUser({bool isForceLogout = false});

  Future<bool> changePassword(String currentPassword, String newPassword);
}
