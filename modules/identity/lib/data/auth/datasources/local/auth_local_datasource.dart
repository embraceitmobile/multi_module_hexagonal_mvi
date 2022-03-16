import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:identity/data/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity/data/auth/datasources/local/dtos/auth_info_dto.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IAuthLocalDatasource)
class AuthLocalDatasource extends SembastBaseLocalDataSource<AuthInfoDto>
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
    final result = await findAll();
    return result.firstOrNull;
  }

  Future<bool> hasAuth() async => await auth != null;

  Future<void> saveAuth(AuthInfoDto auth) async => await insertOrUpdate(auth);

  Future<void> updateAuth(AuthInfoDto auth) async => await update(auth);

  Future<void> removeAuth() async => await clear() > 0;

  Stream<AuthInfoDto?> observeAuth() => observeChange();
}
