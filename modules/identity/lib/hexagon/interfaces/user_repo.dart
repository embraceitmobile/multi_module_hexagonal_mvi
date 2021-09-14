import 'package:core/core.dart';
import 'package:identity_module/hexagon/entities/user.dart';

abstract class UserRepository {
  Future<User?> get activeUser;

  Future<User?> getUserById(int id);

  Future<void> saveUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> removeUser(int userId);

  Future<void> clearUsers();

  Stream<State<User>?> observeActiveUser();
}
