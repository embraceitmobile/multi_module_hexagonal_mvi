import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';

abstract class UserRepository {
  Future<User?> get activeUser;

  Future<List<User>> get users;

  Future<User?> getUserById(int userId);

  Future<bool> saveUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> removeUser(int userId);

  Future<bool> clearUsers();

  Stream<DataState<User>> observeActiveUser();
}
