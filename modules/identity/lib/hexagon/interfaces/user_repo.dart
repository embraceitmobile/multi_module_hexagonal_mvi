import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';

abstract class UserRepository {
  Future<User?> get activeUser;

  Future<User?> getUserById(int id);

  Future<bool> saveUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> removeUser(int userId);

  Future<void> clearUsers();

  Stream<State<User?>> observeActiveUser();
}
