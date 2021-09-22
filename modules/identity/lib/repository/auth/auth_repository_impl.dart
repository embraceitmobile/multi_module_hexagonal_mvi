import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';
import 'package:identity/identity.dart';
import 'package:identity/repository/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity/repository/auth/datasources/local/models/auth_model.dart';
import 'package:identity/repository/auth/datasources/remote/apis/change_password_api.dart';
import 'package:identity/repository/auth/datasources/remote/i_auth_remote_datasource.dart';
import 'package:injectable/injectable.dart';

import 'datasources/remote/apis/login_api.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final IAuthLocalDatasource _localDatasource;
  final IAuthRemoteDatasource _remoteDatasource;

  const AuthRepositoryImpl(this._localDatasource, this._remoteDatasource);

  Future<AuthInfo?> get authInfo async {
    final authModel = await _localDatasource.auth;
    if (authModel == null) return null;

    switch (authModel.state) {
      case LocalState.success:
        return authModel.toAuthToken;
      case LocalState.loading:
      case LocalState.failed:
        return null;
    }
  }

  Future<bool> get isAuthenticated async => await _localDatasource.hasAuth();

  Future<bool> login(String email, String password) async {
    try {
      await _localDatasource.saveAuth(AuthModel.loading());
      final response = await _remoteDatasource.login(
          LoginRequest(userNameOrEmailAddress: email, password: password));

      await saveAuthToken(AuthInfo(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        userId: response.userId,
      ));

      return true;
    } on Exception catch (_) {
      await _localDatasource.saveAuth(AuthModel.failed());
      rethrow;
    }
  }

  Future<bool> logoutActiveUser({bool isForceLogout = false}) async {
    try {
      final auth = await _localDatasource.auth;

      if (!isForceLogout) {
        try {
          if (auth == null)
            throw InvalidDataException("No active user found to logout");
          await _localDatasource
              .saveAuth(auth.copyWith(state: LocalState.loading));
          await _remoteDatasource.logout();
        } on Exception {
          rethrow;
        }
      }

      return await _localDatasource.removeAuth();
    } on Exception {
      rethrow;
    }
  }

  Future<bool> saveAuthToken(AuthInfo authToken) async {
    try {
      final result =
          await _localDatasource.saveAuth(AuthModel.fromAuthInfo(authToken));
      return result > 0;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    try {
      final response = await _remoteDatasource
          .changePassword(ChangePasswordRequest(currentPassword, newPassword));
      return response.success;
    } on Exception {
      rethrow;
    }
  }

  Stream<DataState<AuthState>> observeAuthState() {
    return _localDatasource.observeAuth().map((auth) {
      if (auth == null) return DataState.success(AuthState.Unauthenticated);

      switch (auth.state) {
        case LocalState.loading:
          return DataState.loading();
        case LocalState.success:
          return DataState.success(AuthState.Authenticated);
        case LocalState.failed:
          return DataState.error(Exception("Error in getting auth data_state"));
      }
    });
  }
}
