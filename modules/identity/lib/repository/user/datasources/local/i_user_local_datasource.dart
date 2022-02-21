import 'dtos/user_dto.dart';

abstract class IUserLocalDatasource {
  Future<UserDto?> get user;

  Future<bool> saveUser(UserDto user);

  Future<bool> updateUser(UserDto user);

  Future<bool> removeUser(int userId);

  Future<bool> clearUsers();

  Stream<UserDto?> observeActiveUser();
}
