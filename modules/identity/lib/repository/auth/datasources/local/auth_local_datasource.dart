import 'package:core/clients/local_db_client/base/i_local_db_client.dart';
import 'package:core/clients/local_db_client/local_data_source.dart';
import 'package:core/core.dart';
import 'package:identity/repository/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity/repository/auth/datasources/local/models/auth_model.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAuthLocalDatasource)
class AuthLocalDatasource extends LocalDataSource<AuthModel>
    implements IAuthLocalDatasource {
  static const TAG = "AuthLocalDatasource";
  static const String AUTH_STORE_NAME = 'auth_store';

  AuthLocalDatasource(ILocalDbClient dbClient)
      : super(
          dbClient: dbClient,
          storeName: AUTH_STORE_NAME,
          mapper: (map) => AuthModel.fromEntityMap(map),
        );

  Future<AuthModel?> get auth async {
    final result = await find();
    return result.firstOrNull();
  }

  Future<bool> hasAuth() async {
    final authModel = await auth;
    return authModel != null && authModel.state == LocalState.success;
  }

  Future<int> saveAuth(AuthModel auth) async => await insertOrUpdate(auth);

  Future<bool> updateAuth(AuthModel auth) async => await update(auth) > 0;

  Future<bool> removeAuth() async => await clear() > 0;

  Stream<AuthModel?> observeAuth() => observeChange();
}
