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

  late MergedStreamController<DataState<User>>
      _activeUserRemoteStreamController;

  final Map<int, MergedStreamController<DataState<User>>> _userByIdStreamMap =
      {};

  UserRepositoryImpl(
    this._localDatasource,
    this._remoteDatasource,
    this._authRepository,
  ) {
    _activeUserRemoteStreamController = MergedStreamController.broadcast(
        streamsToMerge: [_localDatasource.observeActiveUser().toUser]);
  }

  Future<User?> get activeUser async {
    try {
      final user = await _localDatasource.activeUser;
      if (user != null) return user.toUser;

      final authInfo = await _authRepository.authInfo;
      if (authInfo == null) {
        throw Exception("The user is not authenticated");
      }

      try {
        _activeUserRemoteStreamController.emit(DataState.loading());
        final response = await _remoteDatasource.getActiveUser();
        final userModel = UserModel.fromUserResponse(response);
        await _localDatasource.saveUser(userModel);
        return userModel.toUser;
      } on Exception catch (error) {
        _activeUserRemoteStreamController.emit(DataState.error(error));
        rethrow;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<User?> getUserById(int userId) async {
    try {
      final user = await _localDatasource.getUserById(userId);
      if (user != null) return user.toUser;

      try {
        _userByIdStreamMap[userId]?.emit(DataState.loading());
        final response =
            await _remoteDatasource.getUserById(GetUserRequest(userId));
        final userModel = UserModel.fromUserResponse(response);
        await _localDatasource.saveUser(userModel);
        return userModel.toUser;
      } on Exception catch (error) {
        _userByIdStreamMap[userId]?.emit(DataState.error(error));
        rethrow;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<bool> saveUser(User user) async {
    try {
      return await _localDatasource.saveUser(UserModel.fromUser(user));
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

  Future<List<User>> get users async {
    try {
      final result = await _localDatasource.users;
      return result.map((user) => user.toUser).toList();
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

  Stream<DataState<User>> observeActiveUser() =>
      _activeUserRemoteStreamController.stream;

  Stream<DataState<User>> observeUserById(int userId) {
    if (_userByIdStreamMap[userId] != null) {
      return _userByIdStreamMap[userId]!.stream;
    }

    final mergedStream = MergedStreamController.broadcast(
        streamsToMerge: [_localDatasource.observeUserById(userId).toUser],
        onCancel: () => _userByIdStreamMap.remove(userId));

    _userByIdStreamMap[userId] = mergedStream;
    return mergedStream.stream;
  }
}

extension on Stream<UserModel?> {
  Stream<DataState<User>> get toUser => this.map((user) => user == null
      ? DataState<User>.idleOrNoData()
      : DataState<User>.success(user.toUser));
}
