import 'dart:async';

import 'package:core/core.dart';
import 'package:identity/domain/entities/auth_info.dart';
import 'package:identity/identity.dart';
import 'package:identity/data/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity/data/auth/datasources/local/dtos/auth_info_dto.dart';
import 'package:identity/data/auth/datasources/remote/apis/change_password_api.dart';
import 'package:identity/data/auth/datasources/remote/i_auth_remote_datasource.dart';
import 'package:injectable/injectable.dart';
import 'datasources/remote/apis/login_api.dart';

@Singleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final IAuthLocalDatasource _localDatasource;
  final IAuthRemoteDatasource _remoteDatasource;

  late NetworkBoundResource<AuthInfo> _authInfoResource;

  AuthRepositoryImpl(this._localDatasource, this._remoteDatasource) {
    _authInfoResource = NetworkBoundResource(
      localDataSourceObservable:
          _localDatasource.observeAuth().toDataStateStream,
      shouldFetch: () async => await authInfo != null,
      onFetchLocalData: () => authInfo,
      onFetchRemoteData: () async => null,
      onSaveResultToLocal: (response) =>
          _localDatasource.saveAuth(AuthInfoDto.fromAuthInfo(response)),
    );
  }

  Future<AuthInfo?> get authInfo async => await _localDatasource.auth;

  Future<bool> get isAuthenticated async => await _localDatasource.hasAuth();

  Future<bool> login(String email, String password) async {
    final loginResponse =
        await _authInfoResource.fetchOnceFromRemoteDatasource(() async {
      try {
        final response = await _remoteDatasource
            .login(LoginRequest(username: email, password: password));
        return response.toAuthInfo;
      } on Exception {
        rethrow;
      }
    });
    return loginResponse != null;
  }

  Future<void> logoutUser({bool isForceLogout = false}) async {
    try {
      final auth = await _localDatasource.auth;

      if (!isForceLogout) {
        try {
          if (auth == null)
            throw InvalidDataException("No active user found to logout");

          await _authInfoResource.fetchOnceFromRemoteDatasource(() async {
            try {
              await _remoteDatasource.logout();
            } catch (e) {
              rethrow;
            }
            return null;
          });
        } on Exception {
          rethrow;
        }
      }

      return await _localDatasource.removeAuth();
    } on Exception {
      rethrow;
    }
  }

  Future<void> saveAuthInfo(AuthInfo authInfo) async {
    try {
      await _localDatasource.saveAuth(AuthInfoDto.fromAuthInfo(authInfo));
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

  Stream<Resource<AuthInfo>> observeAuthInfo() =>
      _authInfoResource.dataListener;
}
