import 'dart:async';

import 'package:core/core.dart';
import 'package:identity/domain/entities/user.dart';
import 'package:identity/domain/interfaces/auth_repo.dart';
import 'package:identity/domain/interfaces/user_repo.dart';
import 'package:identity/data/user/datasources/local/i_user_local_datasource.dart';
import 'package:identity/data/user/datasources/remote/apis/get_user_api.dart';
import 'package:identity/data/user/datasources/remote/i_user_remote_datasource.dart';
import 'package:injectable/injectable.dart';
import 'datasources/local/dtos/user_dto.dart';

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

  Future<void> saveUser(User user) async {
    try {
      await _localDatasource.saveUser(UserDto.fromUser(user));
    } on Exception {
      rethrow;
    }
  }

  Future<void> updateUser(User user) async {
    try {
      await _localDatasource.updateUser(UserDto.fromUser(user));
    } on Exception {
      rethrow;
    }
  }

  Future<void> removeUser(int userId) async {
    try {
      await _localDatasource.removeUser(userId);
    } on Exception {
      rethrow;
    }
  }

  Future<void> clearUsers() async {
    try {
      await _localDatasource.clearUsers();
    } on Exception {
      rethrow;
    }
  }

  Stream<DataState<User>> observeActiveUser() => _userResource.dataListener;
}
