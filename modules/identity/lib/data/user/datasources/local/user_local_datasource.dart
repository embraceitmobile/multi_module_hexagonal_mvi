import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:identity/data/user/datasources/local/i_user_local_datasource.dart';
import 'package:injectable/injectable.dart';
import 'dtos/user_dto.dart';

@Singleton(as: IUserLocalDatasource)
class UserLocalDatasource extends SembastBaseLocalDataSource<UserDto>
    implements IUserLocalDatasource {
  static const TAG = "UserLocalDatasource";
  static const String USER_STORE_NAME = 'user_store';

  UserLocalDatasource(ILocalDbClient dbClient)
      : super(
          dbClient: dbClient,
          storeName: USER_STORE_NAME,
          mapper: (map) => UserDto.fromEntityMap(map),
        );

  Future<UserDto?> get user async => (await findAll()).firstOrNull;

  Future<void> saveUser(UserDto user) async => await insertOrUpdate(user);

  Future<void> updateUser(UserDto user) async => await update(user);

  Future<void> removeUser(int userId) async => await delete(userId.toString());

  Future<void> clearUsers() async => await clear() > 0;

  Stream<UserDto?> observeActiveUser() => observeChange();
}
