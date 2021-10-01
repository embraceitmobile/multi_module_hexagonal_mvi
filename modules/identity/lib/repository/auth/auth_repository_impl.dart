import 'dart:async';

import 'package:async/async.dart';
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

  final StreamController<DataState<AuthInfo>> _authInfoRemoteStreamController;
  late Stream<DataState<AuthInfo>> _groupedAuthStateStream;

  AuthRepositoryImpl(this._localDatasource, this._remoteDatasource)
      : _authInfoRemoteStreamController =
            StreamController<DataState<AuthInfo>>.broadcast() {
    final localAuthInfoStream = _localDatasource.observeAuth().map((authInfo) =>
        authInfo == null
            ? DataState<AuthInfo>.nullOrEmpty()
            : DataState<AuthInfo>.success(authInfo));

    _groupedAuthStateStream = StreamGroup.mergeBroadcast([
      localAuthInfoStream,
      _authInfoRemoteStreamController.stream,
    ]);
  }

  Future<AuthInfo?> get authInfo async => await _localDatasource.auth;

  Future<bool> get isAuthenticated async => await _localDatasource.hasAuth();

  Future<bool> login(String email, String password) async {
    try {
      _authInfoRemoteStreamController.sink.add(DataState.loading());
      final response = await _remoteDatasource.login(
          LoginRequest(userNameOrEmailAddress: email, password: password));

      return await saveAuthInfo(response.toAuthInfo);
    } on Exception catch (error) {
      _authInfoRemoteStreamController.sink.add(DataState.error(error));
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
          _authInfoRemoteStreamController.sink.add(DataState.loading());
          await _remoteDatasource.logout();
        } on Exception catch (error) {
          _authInfoRemoteStreamController.sink.add(DataState.error(error));
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

  Stream<DataState<AuthInfo>> observeAuthInfo() => _groupedAuthStateStream;
}
