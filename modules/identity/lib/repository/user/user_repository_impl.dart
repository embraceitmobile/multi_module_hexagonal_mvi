import 'dart:async';

import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';
import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/hexagon/interfaces/user_repo.dart';
import 'package:identity/repository/user/datasources/local/i_user_local_datasource.dart';
import 'package:identity/repository/user/datasources/local/models/user_model.dart';
import 'package:identity/repository/user/datasources/remote/apis/get_user_api.dart';
import 'package:identity/repository/user/datasources/remote/i_user_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final IUserLocalDatasource _localDatasource;
  final IUserRemoteDatasource _remoteDatasource;
  final AuthRepository _authRepository;

  late NetworkBoundResource<User> _userResource;

  UserRepositoryImpl(
    this._localDatasource,
    this._remoteDatasource,
    this._authRepository,
  ) {
    _userResource = NetworkBoundResource(
      localDataSourceObservable:
          _localDatasource.observeActiveUser().toDataStateStream,
      shouldFetch: () async => await _localDatasource.user == null,
      onFetchLocalData: () => _localDatasource.user,
      onFetchRemoteData: () async {
        final authInfo = await _authRepository.authInfo;
        if (authInfo == null) {
          throw Exception("The user is not authenticated");
        }

        return await _remoteDatasource
            .getUserById(GetUserRequest(authInfo.userId));
      },
      onSaveResultToLocal: (response) => saveUser(response),
    );
  }

  Future<User?> get user async {
    try {
      return await _userResource.fetch();
    } on Exception {
      rethrow;
    }
  }

  Future<bool> saveUser(User user) async {
    try {
      final result = await _localDatasource.saveUser(UserModel.fromUser(user));
      return result;
    } on Exception {
      rethrow;
    }
  }

  Future<bool> updateUser(User user) async {
    try {
      return await _localDatasource.updateUser(UserModel.fromUser(user));
    } on Exception {
      rethrow;
    }
  }

  Future<bool> removeUser(int userId) async {
    try {
      return await _localDatasource.removeUser(userId);
    } on Exception {
      rethrow;
    }
  }

  Future<bool> clearUsers() async {
    try {
      return await _localDatasource.clearUsers();
    } on Exception {
      rethrow;
    }
  }

  Stream<DataState<User>> observeActiveUser() => _userResource.dataListener;
}
