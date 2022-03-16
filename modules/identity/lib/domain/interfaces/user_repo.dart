import 'package:core/core.dart';
import 'package:identity/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> get user;

  Future<void> saveUser(User user);

  Future<void> updateUser(User user);

  Future<void> removeUser(int userId);

  Future<void> clearUsers();

  Stream<DataState<User>> observeActiveUser();
}
