import 'package:collection/collection.dart';
import 'package:core/core_pure_dart.dart';
import 'package:identity/data/user/datasources/local/i_user_local_datasource.dart';
import 'package:identity/domain/entities/user.dart';
import 'package:injectable/injectable.dart';
import 'dtos/user_dto.dart';

@Singleton(as: IUserLocalDatasource)
class UserLocalDatasource extends SembastBaseLocalDataSource<int, UserDto>
    implements IUserLocalDatasource {
  static const TAG = "UserLocalDatasource";
  static const String USER_STORE_NAME = 'user_store';

  UserLocalDatasource(ILocalDbClient dbClient)
      : super(
          dbClient: dbClient,
          storeName: USER_STORE_NAME,
          mapper: (map) => UserDto.fromEntityMap(map),
        );

  Future<User?> get user async => (await findAll()).firstOrNull;

  Future<void> saveUser(User user) async =>
      await insertOrUpdate(UserDto.fromUser(user));

  Future<void> updateUser(User user) async =>
      await update(UserDto.fromUser(user));

  Future<void> removeUser(int userId) async => await delete(userId);

  Future<void> clearUsers() async => await clear() > 0;

  Stream<UserDto?> observeActiveUser() => observeChange();
}
