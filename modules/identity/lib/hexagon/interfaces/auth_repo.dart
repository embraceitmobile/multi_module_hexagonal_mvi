import 'package:core/core.dart';
import 'package:identity_module/hexagon/entities/auth_state.dart';
import 'package:identity_module/hexagon/entities/auth_token.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<AuthToken?> get authToken;

  Future<bool> saveAuthToken(AuthToken authToken);

  Stream<State<AuthState>> observeAuthState();

  Future<bool> login(String email, String password);

  Future<bool> logoutActiveUser({bool isForceLogout = false});

  Future<bool> changePassword(String currentPassword, String newPassword);
}
