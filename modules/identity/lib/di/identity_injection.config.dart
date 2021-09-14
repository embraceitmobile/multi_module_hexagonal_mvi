// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:core/clients/remote_api_client/base/i_remote_api_client.dart'
    as _i15;
import 'package:core/core.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../hexagon/interfaces/auth_repo.dart' as _i5;
import '../hexagon/interfaces/user_repo.dart' as _i18;
import '../hexagon/use_cases/auth/auth_actions_impl.dart' as _i4;
import '../hexagon/use_cases/auth/auth_listener_impl.dart' as _i6;
import '../hexagon/use_cases/auth/auth_reader_impl.dart' as _i7;
import '../hexagon/use_cases/auth/auth_use_cases.dart' as _i3;
import '../hexagon/use_cases/user/user_editor_impl.dart' as _i23;
import '../hexagon/use_cases/user/user_reader_impl.dart' as _i24;
import '../hexagon/use_cases/user/user_use_cases.dart' as _i22;
import '../identity.dart' as _i20;
import '../repository/auth/auth_repo_impl.dart' as _i21;
import '../repository/auth/datasources/local/auth_local_datasource.dart' as _i9;
import '../repository/auth/datasources/local/i_auth_local_datasource.dart'
    as _i8;
import '../repository/auth/datasources/remote/auth_remote_datasource.dart'
    as _i12;
import '../repository/auth/datasources/remote/i_auth_remote_datasource.dart'
    as _i11;
import '../repository/user/datasources/local/i_user_local_datasource.dart'
    as _i16;
import '../repository/user/datasources/local/user_local_datasource.dart'
    as _i17;
import '../repository/user/datasources/remote/i_user_remote_datasource.dart'
    as _i13;
import '../repository/user/datasources/remote/user_remote_dataosource.dart'
    as _i14;
import '../repository/user/user_repo_impl.dart'
    as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singletonWithDependencies<_i3.AuthActions>(
      () => _i4.AuthActionsImpl(get<_i5.AuthRepository>()),
      dependsOn: [_i5.AuthRepository]);
  gh.singletonWithDependencies<_i3.AuthListener>(
      () => _i6.AuthListenerImpl(get<_i5.AuthRepository>()),
      dependsOn: [_i5.AuthRepository]);
  gh.singletonWithDependencies<_i3.AuthReader>(
      () => _i7.AuthReaderImpl(get<_i5.AuthRepository>()),
      dependsOn: [_i5.AuthRepository]);
  gh.singleton<_i8.IAuthLocalDatasource>(
      _i9.AuthLocalDatasource(get<_i10.ILocalDbClient>()));
  gh.singleton<_i11.IAuthRemoteDatasource>(_i12.AuthRemoteDatasource(
      get<_i10.IRemoteApiClient<_i10.BaseResponse>>()));
  gh.singleton<_i13.IRemoteUserDatasource>(_i14.RemoteUserDatasource(
      get<_i15.IRemoteApiClient<_i10.BaseResponse>>()));
  gh.singleton<_i16.IUserLocalDatasource>(
      _i17.UserLocalDatasource(get<_i10.ILocalDbClient>()));
  gh.singletonWithDependencies<_i18.UserRepository>(
      () => _i19.UserRepoImpl(get<_i16.IUserLocalDatasource>(),
          get<_i13.IRemoteUserDatasource>(), get<_i5.AuthRepository>()),
      dependsOn: [_i5.AuthRepository]);
  gh.singleton<_i20.AuthRepository>(_i21.AuthRepoImpl(
      get<_i8.IAuthLocalDatasource>(), get<_i11.IAuthRemoteDatasource>()));
  gh.singleton<_i22.UserEditor>(
      _i23.UserEditorImpl(get<_i18.UserRepository>()));
  gh.singleton<_i22.UserReader>(
      _i24.UserReaderImpl(get<_i18.UserRepository>()));
  return get;
}
