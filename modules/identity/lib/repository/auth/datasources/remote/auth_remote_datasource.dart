import 'package:core/core.dart';
import 'package:identity_module/repository/auth/datasources/remote/apis/change_password_api.dart';
import 'package:identity_module/repository/auth/datasources/remote/apis/login_api.dart';
import 'package:identity_module/repository/auth/datasources/remote/apis/logout_api.dart';
import 'package:injectable/injectable.dart';

import 'i_auth_remote_datasource.dart';

@Singleton(as: IAuthRemoteDatasource)
class AuthRemoteDatasource implements IAuthRemoteDatasource {
  static const String TAG = "UserApiImplementation";
  final IRemoteApiClient<BaseResponse> _apiClient;

  // injecting api client instance
  AuthRemoteDatasource(this._apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.post(
        loginEndpoint,
        data: request.toMap(),
      );

      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      return LoginResponse.fromMap(response.result);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  Future<LogoutResponse> logout() async {
    try {
      final response = await _apiClient.post(logoutEndpoint);

      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      return LogoutResponse.fromBaseResponse(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException catch (ex) {
      if (ex.error.statusCode == 401)
        return LogoutResponse(true);
      else
        rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest request) async {
    try {
      final response =
          await _apiClient.post(changePasswordEndpoint, data: request.toMap());

      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      return ChangePasswordResponse.fromBaseResponse(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }
}
