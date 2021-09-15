import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: AuthActions)
class AuthActionsImpl implements AuthActions {
  final AuthRepository _repository;

  const AuthActionsImpl(this._repository);

  Future<bool> login(String email, String password) async {
    try {
      return await _repository.login(email, password);
    } on Exception {
      rethrow;
    }
  }

  Future<bool> logoutActiveUser({bool isForceLogout = false}) async {
    try {
      return await _repository.logoutActiveUser(isForceLogout: isForceLogout);
    } on Exception {
      rethrow;
    }
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    try {
      return await _repository.changePassword(currentPassword, newPassword);
    } on Exception {
      rethrow;
    }
  }
}
