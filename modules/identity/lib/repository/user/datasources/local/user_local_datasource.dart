import 'package:collection/collection.dart';
import 'package:core/clients/local_db_client/base/i_local_db_client.dart';
import 'package:core/clients/local_db_client/local_data_source.dart';
import 'package:core/core.dart';
import 'package:identity/repository/user/datasources/local/i_user_local_datasource.dart';
import 'package:injectable/injectable.dart';
import 'dtos/user_dto.dart';

@Singleton(as: IUserLocalDatasource)
class UserLocalDatasource extends LocalDataSource<UserDto>
    implements IUserLocalDatasource {
  static const TAG = "UserLocalDatasource";
  static const String USER_STORE_NAME = 'user_store';

  UserLocalDatasource(ILocalDbClient dbClient)
      : super(
          dbClient: dbClient,
          storeName: USER_STORE_NAME,
          mapper: (map) => UserDto.fromEntityMap(map),
        );

  Future<UserDto?> get user async => (await find()).firstOrNull;

  Future<void> saveUser(UserDto user) async => await insertOrUpdate(user);

  Future<void> updateUser(UserDto user) async => await update(user);

  Future<void> removeUser(int userId) async =>
      await deleteById(userId.toString());

  Future<void> clearUsers() async => await clear() > 0;

  Stream<UserDto?> observeActiveUser() => observeChange();
}
