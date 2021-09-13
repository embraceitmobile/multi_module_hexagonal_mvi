import 'package:identity_module/repository/auth/datasources/remote/apis/login_api.dart';
import 'package:identity_module/repository/auth/datasources/remote/apis/logout_api.dart';

import 'apis/change_password_api.dart';

abstract class IAuthRemoteDatasource {
  Future<LoginResponse> login(LoginRequest request);

  Future<LogoutResponse> logout();

  Future<ChangePasswordResponse> changePassword(ChangePasswordRequest request);
}
