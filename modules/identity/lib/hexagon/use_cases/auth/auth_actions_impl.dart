import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/hexagon/interfaces/user_repo.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthActions)
class AuthActionsImpl implements AuthActions {
  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  const AuthActionsImpl(this._authRepository, this._userRepository);

  Future<bool> login(String email, String password) async {
    try {
      return await _authRepository.login(email, password);
    } on Exception {
      rethrow;
    }
  }

  Future<bool> logoutUser({bool isForceLogout = false}) async {
    try {
      _authRepository.logoutUser(isForceLogout: isForceLogout);
      final currentUser = await _userRepository.user;
      if (currentUser != null)
        Future.delayed(Duration(milliseconds: 500),
            () => _userRepository.removeUser(currentUser.id));
      return true;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    try {
      return await _authRepository.changePassword(currentPassword, newPassword);
    } on Exception {
      rethrow;
    }
  }
}
