import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';

abstract class UserReader {
  Future<User?> get user;
}

abstract class UserListener {
  Stream<DataState<User>> observeUser();
}

abstract class UserEditor extends UserReader {
  Future<bool> updateUser(User user);

  Future<bool> removeUser(int userId);
}
