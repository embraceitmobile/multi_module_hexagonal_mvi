import 'dart:async';

import 'package:core/core.dart';
import 'package:identity/hexagon/entities/auth_info.dart';
import 'package:identity/identity.dart';
import 'package:identity/repository/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity/repository/auth/datasources/local/models/auth_info_dto.dart';
import 'package:identity/repository/auth/datasources/remote/apis/change_password_api.dart';
import 'package:identity/repository/auth/datasources/remote/i_auth_remote_datasource.dart';
import 'package:injectable/injectable.dart';

import 'datasources/remote/apis/login_api.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final IAuthLocalDatasource _localDatasource;
  final IAuthRemoteDatasource _remoteDatasource;
  final StreamController<DataState<AuthInfo>> _authInfoStreamController;

  AuthRepositoryImpl(this._localDatasource, this._remoteDatasource)
      : _authInfoStreamController =
            StreamController<DataState<AuthInfo>>.broadcast();

  Future<AuthInfo?> get authInfo async => await _localDatasource.auth;

  Future<bool> get isAuthenticated async => await _localDatasource.hasAuth();

  Future<bool> login(String email, String password) async {
    try {
      _authInfoStreamController.sink.add(DataState.loading());
      final response = await _remoteDatasource.login(
          LoginRequest(userNameOrEmailAddress: email, password: password));

      final authInfo = AuthInfo(
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        userId: response.userId,
      );

      await saveAuthInfo(authInfo);

      _authInfoStreamController.sink.add(DataState.success(authInfo));
      return true;
    } on Exception catch (error) {
      _authInfoStreamController.sink.add(DataState.error(error));
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
          _authInfoStreamController.sink.add(DataState.loading());
          await _remoteDatasource.logout();
        } on Exception catch (error) {
          _authInfoStreamController.sink.add(DataState.error(error));
          rethrow;
        }
      }

      return await _localDatasource.removeAuth();
    } on Exception {
      rethrow;
    }
  }

  Future<bool> saveAuthInfo(AuthInfo authInfo) async {
    try {
      final result =
          await _localDatasource.saveAuth(AuthInfoDto.fromAuthInfo(authInfo));
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

  Stream<DataState<AuthInfo>> observeAuthInfo() =>
      _authInfoStreamController.stream;
}
