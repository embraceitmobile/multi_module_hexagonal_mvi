import 'package:identity/data/auth/datasources/remote/dtos/login_api.dart';
import 'package:identity/data/auth/datasources/remote/dtos/logout_api.dart';

import 'dtos/change_password_api.dart';

abstract class IAuthRemoteDatasource {
  Future<LoginResponse> login(LoginRequest request);

  Future<LogoutResponse> logout();

  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);
}
