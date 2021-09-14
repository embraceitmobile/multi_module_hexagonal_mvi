import 'package:core/core.dart';
import 'package:core/models/state/state.dart';
import 'package:identity/hexagon/entities/user.dart';
import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/hexagon/interfaces/user_repo.dart';
import 'package:identity/repository/user/datasources/local/i_user_local_datasource.dart';
import 'package:identity/repository/user/datasources/local/models/user_model.dart';
import 'package:identity/repository/user/datasources/remote/apis/get_user_api.dart';
import 'package:identity/repository/user/datasources/remote/i_user_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: UserRepository)
class UserRepoImpl implements UserRepository {
  final IUserLocalDatasource _localDatasource;
  final IRemoteUserDatasource _remoteDatasource;
  final AuthRepository _authRepository;

  UserRepoImpl(
      this._localDatasource, this._remoteDatasource, this._authRepository);

  Future<User?> get activeUser async {
    if (!(await _authRepository.isAuthenticated)) return null;

    try {
      final user = await _localDatasource.activeUser;

      if (user == null) {
        final authInfo = await _authRepository.authInfo;

        if (authInfo == null) {
          throw Exception("No auth info found in auth repository");
        }

        await _localDatasource.saveUser(UserModel.loading(authInfo.userId));

        try {
          final response = await _remoteDatasource.getActiveUser();
          await _localDatasource.saveUser(UserModel.fromUserResponse(response));
          return (await _localDatasource.activeUser)!.toUser;
        } on Exception {
          await _localDatasource.saveUser(UserModel.failed(authInfo.userId));
          return null;
        }
      } else {
        return user.toUser;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<User?> getUserById(int userId) async {
    try {
      final user = await _localDatasource.getUserById(userId);
      if (user == null) {
        try {
          final response =
              await _remoteDatasource.getUserById(GetUserRequest(userId));
          await _localDatasource.saveUser(UserModel.fromUserResponse(response));
          return (await _localDatasource.getUserById(userId))!.toUser;
        } on Exception {
          await _localDatasource.saveUser(UserModel.failed(userId));
          return null;
        }
      } else {
        return user.toUser;
      }
    } on Exception {
      rethrow;
    }
  }

  Future<bool> saveUser(User user) async {
    return await _localDatasource.saveUser(UserModel.fromUser(user));
  }

  Future<bool> updateUser(User user) async {
    return await _localDatasource.updateUser(UserModel.fromUser(user));
  }

  Future<bool> removeUser(int userId) async {
    return await _localDatasource.removeUser(userId);
  }

  Future<bool> clearUsers() async {
    return await _localDatasource.clearUsers();
  }

  Stream<State<User>> observeActiveUser() {
    return _localDatasource.observeActiveUser().map((user) {
      if (user == null) return State.nullOrEmpty();

      switch (user.state) {
        case LocalState.success:
          return State.success(user.toUser);
        case LocalState.loading:
          return State.loading();
        case LocalState.failed:
          return State.error(Exception());
      }
    });
  }
}
