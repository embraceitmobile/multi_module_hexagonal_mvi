import 'package:identity/repository/user/datasources/local/models/user_model.dart';

abstract class IUserLocalDatasource {
  Future<UserModel?> get activeUser;

  Future<UserModel?> getUserById(int userId);

  Future<bool> saveUser(UserModel user);

  Future<bool> updateUser(UserModel user);

  Future<bool> removeUser(int userId);

  Future<List<UserModel>> get users;

  Future<bool> clearUsers();

  Stream<UserModel?> observeActiveUser();

  Stream<UserModel?> observeUserById(int userId);
}
