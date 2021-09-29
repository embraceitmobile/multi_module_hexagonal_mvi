import 'package:core/clients/local_db_client/base/i_local_db_client.dart';
import 'package:core/clients/local_db_client/local_data_source.dart';
import 'package:core/core.dart';
import 'package:identity/repository/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity/repository/auth/datasources/local/models/auth_info_dto.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAuthLocalDatasource)
class AuthLocalDatasource extends LocalDataSource<AuthInfoDto>
    implements IAuthLocalDatasource {
  static const TAG = "AuthLocalDatasource";
  static const String AUTH_STORE_NAME = 'auth_store';

  AuthLocalDatasource(ILocalDbClient dbClient)
      : super(
          dbClient: dbClient,
          storeName: AUTH_STORE_NAME,
          mapper: (map) => AuthInfoDto.fromDtoMap(map),
        );

  Future<AuthInfoDto?> get auth async {
    final result = await find();
    return result.firstOrNull();
  }

  Future<bool> hasAuth() async => await auth != null;

  Future<int> saveAuth(AuthInfoDto auth) async => await insertOrUpdate(auth);

  Future<bool> updateAuth(AuthInfoDto auth) async => await update(auth) > 0;

  Future<bool> removeAuth() async => await clear() > 0;

  Stream<AuthInfoDto?> observeAuth() => observeChange();
}
