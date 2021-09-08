import 'package:core/core.dart';
import 'package:identity_module/hexagon/entities/auth_state.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<String?> get accessToken;

  Future<String?> get refreshToken;

  Future<void> saveAccessToken(String accessToken);

  Future<void> saveRefreshToken(String refreshToken);

  Stream<State<AuthState>> observeAuthState();

  Future<bool> login(String email, String password);

  Future<bool> logoutActiveUser();

  Future<bool> changePassword(String currentPassword, String newPassword);
}
