import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';

abstract class UserReader {
  Future<User?> get activeUser;

  Future<User?> getUserById(int id);

  Future<List<User>> get users;
}

abstract class UserListener {
  Stream<DataState<User>> observeActiveUser();
}

abstract class UserEditor extends UserReader {
  Future<bool> updateUser(User user);

  Future<bool> removeUser(int userId);
}
