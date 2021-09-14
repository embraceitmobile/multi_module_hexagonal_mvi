import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';

abstract class UserReader {
  Future<User?> get activeUser;

  Future<User?> getUserById(int id);
}

abstract class UserListener {
  Stream<State<User>?> observeActiveUser();
}

abstract class UserEditor extends UserReader {
  Future<bool> updateUser(User user);
}
