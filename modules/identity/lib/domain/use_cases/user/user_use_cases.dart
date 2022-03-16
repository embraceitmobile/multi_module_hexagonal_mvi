import 'package:core/core.dart';
import 'package:identity/domain/entities/user.dart';

abstract class UserReader {
  Future<User?> get user;
}

abstract class UserListener {
  Stream<DataState<User>> observeUser();
}

abstract class UserEditor extends UserReader {
  Future<void> updateUser(User user);

  Future<void> removeUser(int userId);
}
