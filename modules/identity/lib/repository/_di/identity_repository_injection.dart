import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:identity/hexagon/interfaces/auth_repo.dart';
import 'package:identity/identity.dart';
import 'package:identity/repository/auth/auth_repository_impl.dart';
import 'package:identity/repository/auth/datasources/local/auth_local_datasource.dart';
import 'package:identity/repository/auth/datasources/local/i_auth_local_datasource.dart';
import 'package:identity/repository/auth/datasources/remote/auth_remote_datasource.dart';
import 'package:identity/repository/auth/datasources/remote/i_auth_remote_datasource.dart';
import 'package:identity/repository/user/datasources/local/i_user_local_datasource.dart';
import 'package:identity/repository/user/datasources/local/user_local_datasource.dart';
import 'package:identity/repository/user/datasources/remote/i_user_remote_datasource.dart';
import 'package:identity/repository/user/datasources/remote/user_remote_datasource.dart';
import 'package:identity/repository/user/user_repository_impl.dart';
import 'package:injectable/injectable.dart';

GetIt configureIdentityRepositoryInjection() {
  final gh = GetItHelper(getIt);

  gh.singleton<IAuthLocalDatasource>(
      AuthLocalDatasource(getIt<ILocalDbClient>()));
  gh.singleton<IAuthRemoteDatasource>(
      AuthRemoteDatasource(getIt<IRemoteApiClient<BaseResponse>>()));
  gh.singleton<AuthRepository>(AuthRepositoryImpl(
    getIt<IAuthLocalDatasource>(),
    getIt<IAuthRemoteDatasource>(),
  ));

  gh.singleton<IUserLocalDatasource>(
      UserLocalDatasource(getIt<ILocalDbClient>()));
  gh.singleton<IUserRemoteDatasource>(
      UserRemoteDatasource(getIt<IRemoteApiClient<BaseResponse>>()));
  gh.singleton<UserRepository>(UserRepositoryImpl(
    getIt<IUserLocalDatasource>(),
    getIt<IUserRemoteDatasource>(),
    getIt<AuthRepository>(),
  ));

  return getIt;
}
