import 'package:core/clients/remote_api_client/dio/dio_client.dart';
import 'package:core/core.dart';
import 'package:identity/identity.dart';
import 'package:injectable/injectable.dart';

import '../local_module.dart';
import '../network_module.dart';

Future<void> configureInjection() async {
  final gh = GetItHelper(getIt);
  final localModule = _LocalModule();
  final networkModule = _NetworkModule();

  gh.singleton<DioClient>(networkModule.dioClient);
  await gh.singletonAsync<ILocalDbClient>(
      () => localModule.provideLocalDbClient(),
      preResolve: true);
  gh.singleton<IRemoteApiClient<dynamic>>(networkModule.remoteApiClient);

  configureIdentityInjection();

  gh.lazySingleton<AuthInterceptor>(() => networkModule.authInterceptor);
  gh.lazySingleton<RetryInterceptor>(() => networkModule.retryInterceptor);

  networkModule.addInterceptors(
    getIt<AuthInterceptor>(),
    getIt<RetryInterceptor>(),
  );
}

class _LocalModule extends LocalModule {}

class _NetworkModule extends NetworkModule {}
