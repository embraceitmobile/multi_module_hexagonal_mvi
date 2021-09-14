import 'package:core/core.dart';
import 'package:core/models/state/state.dart';
import 'package:identity_module/hexagon/entities/auth_token.dart';
import 'package:identity_module/identity.dart';
import 'package:identity_module/repository/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity_module/repository/auth/datasources/local/models/auth_model.dart';
import 'package:identity_module/repository/auth/datasources/remote/apis/change_password_api.dart';
import 'package:identity_module/repository/auth/datasources/remote/i_auth_remote_datasource.dart';
import 'package:injectable/injectable.dart';

import 'datasources/remote/apis/login_api.dart';

@Singleton(as: AuthRepository)
class AuthRepoImpl implements AuthRepository {
  final IAuthLocalDatasource _localDatasource;
  final IAuthRemoteDatasource _remoteDatasource;

  AuthRepoImpl(this._localDatasource, this._remoteDatasource);

  Future<AuthToken?> get authToken async {
    final authModel = await _localDatasource.auth;
    if (authModel == null) return null;

    switch (authModel.state) {
      case LocalState.success:
        return AuthToken(
            accessToken: authModel.accessToken!,
            refreshToken: authModel.refreshToken!);
      case LocalState.loading:
      case LocalState.failed:
        return null;
    }
  }

  Future<bool> get isAuthenticated async => await _localDatasource.hasAuth();

  @override
  Future<bool> login(String email, String password) async {
    try {
      await _localDatasource.saveAuth(AuthModel.loading());
      final response = await _remoteDatasource.login(
          LoginRequest(userNameOrEmailAddress: email, password: password));

      await saveAuthToken(AuthToken(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      ));

      return true;
    } on Exception catch (_) {
      await _localDatasource.saveAuth(AuthModel.failed());
      rethrow;
    }
  }

  @override
  Future<bool> logoutActiveUser({bool isForceLogout = false}) async {
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
  }

  @override
  Future<bool> saveAuthToken(AuthToken authToken) async {
    try {
      final result =
          await _localDatasource.saveAuth(AuthModel.fromAuthToken(authToken));
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

  @override
  Stream<State<AuthState>> observeAuthState() {
    return _localDatasource.observeAuth().map((auth) {
      if (auth == null) return State.success(AuthState.Unauthenticated);

      switch (auth.state) {
        case LocalState.loading:
          return State.loading();
        case LocalState.success:
          return State.success(AuthState.Authenticated);
        case LocalState.failed:
          return State.error(Exception("Error in getting auth state"));
      }
    });
  }
}
