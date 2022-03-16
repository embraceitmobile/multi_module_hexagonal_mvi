import 'dtos/user_dto.dart';

abstract class IUserLocalDatasource {
  Future<UserDto?> get user;

  Future<void> saveUser(UserDto user);

  Future<void> updateUser(UserDto user);

  Future<void> removeUser(int userId);

  Future<void> clearUsers();

  Stream<UserDto?> observeActiveUser();
}
