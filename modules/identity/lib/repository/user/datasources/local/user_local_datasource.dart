import 'package:core/clients/local_db_client/base/i_local_db_client.dart';
import 'package:core/clients/local_db_client/local_data_source.dart';
import 'package:core/core.dart';
import 'package:identity/repository/user/datasources/local/i_user_local_datasource.dart';
import 'package:injectable/injectable.dart';

import 'models/user_model.dart';

@Singleton(as: IUserLocalDatasource)
class UserLocalDatasource extends LocalDataSource<UserModel>
    implements IUserLocalDatasource {
  static const TAG = "UserLocalDatasource";
  static const String USER_STORE_NAME = 'user_store';

  UserLocalDatasource(ILocalDbClient dbClient)
      : super(
          dbClient: dbClient,
          storeName: USER_STORE_NAME,
          mapper: (map) => UserModel.fromEntityMap(map),
        );

  Future<UserModel?> get activeUser async {
    final result = await find(filter: Filter.equals("isActive", true));
    return result.firstOrNull();
  }

  Future<UserModel?> getUserById(int userId) async {
    final result = await find(filter: Filter.equals("userId", userId));
    return result.firstOrNull();
  }

  Future<bool> saveUser(UserModel user) async => await insertOrUpdate(user) > 0;

  Future<bool> updateUser(UserModel user) async => await update(user) > 0;

  Future<bool> removeUser(int userId) async =>
      await deleteById(userId.toString()) > 0;

  Future<List<UserModel>> get users async => await find();

  Future<bool> clearUsers() async => await clear() > 0;

  Stream<UserModel?> observeActiveUser() =>
      observeChange(filter: Filter.equals("isActive", true));
}
