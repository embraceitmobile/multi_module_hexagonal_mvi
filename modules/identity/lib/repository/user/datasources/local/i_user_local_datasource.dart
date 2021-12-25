import 'package:identity/repository/user/datasources/local/models/user_model.dart';

abstract class IUserLocalDatasource {
  Future<UserModel?> get user;

  Future<bool> saveUser(UserModel user);

  Future<bool> updateUser(UserModel user);

  Future<bool> removeUser(int userId);

  Future<bool> clearUsers();

  Stream<UserModel?> observeActiveUser();
}
