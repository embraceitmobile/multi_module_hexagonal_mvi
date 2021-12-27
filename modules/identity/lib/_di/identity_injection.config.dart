// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:core/core.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hexagon/interfaces/auth_repo.dart' as _i14;
import '../hexagon/interfaces/user_repo.dart' as _i12;
import '../repository/auth/datasources/local/auth_local_datasource.dart' as _i4;
import '../repository/auth/datasources/local/i_auth_local_datasource.dart'
    as _i3;
import '../repository/auth/datasources/remote/auth_remote_datasource.dart'
    as _i7;
import '../repository/auth/datasources/remote/i_auth_remote_datasource.dart'
    as _i6;
import '../repository/user/datasources/local/i_user_local_datasource.dart'
    as _i10;
import '../repository/user/datasources/local/user_local_datasource.dart'
    as _i11;
import '../repository/user/datasources/remote/i_user_remote_datasource.dart'
    as _i8;
import '../repository/user/datasources/remote/user_remote_datasource.dart'
    as _i9;
import '../repository/user/user_repository_impl.dart' as _i13;

const String _repo = 'repo';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.IAuthLocalDatasource>(
      _i4.AuthLocalDatasource(get<_i5.ILocalDbClient>()),
      registerFor: {_repo});
  gh.singleton<_i6.IAuthRemoteDatasource>(
      _i7.AuthRemoteDatasource(get<_i5.IRemoteApiClient<dynamic>>()),
      registerFor: {_repo});
  gh.singleton<_i8.IUserRemoteDatasource>(
      _i9.UserRemoteDatasource(get<_i5.IRemoteApiClient<dynamic>>()),
      registerFor: {_repo});
  gh.singleton<_i10.IUserLocalDatasource>(
      _i11.UserLocalDatasource(get<_i5.ILocalDbClient>()),
      registerFor: {_repo});
  gh.singleton<_i12.UserRepository>(
      _i13.UserRepositoryImpl(
        get<_i10.IUserLocalDatasource>(),
        get<_i8.IUserRemoteDatasource>(),
        get<_i14.AuthRepository>(),
      ),
      registerFor: {_repo});
  // gh.singleton<_i15.AuthRepository>(
  //     _i16.AuthRepositoryImpl(
  //         get<_i3.IAuthLocalDatasource>(), get<_i6.IAuthRemoteDatasource>()),
  //     registerFor: {_repo});
  return get;
}
