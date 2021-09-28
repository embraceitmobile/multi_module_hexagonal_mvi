import 'package:core/clients/remote_api_client/dio/dio_client.dart';
import 'package:core/core.dart';
import 'package:identity/hexagon/use_cases/auth/auth_use_cases.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  NetworkModule();

  // DI Providers:--------------------------------------------------------------
  @singleton
  DioClient get dioClient => DioClient();

  @singleton
  IRemoteApiClient<dynamic> get remoteApiClient =>
      RemoteApiClient(getIt<DioClient>().dio);

  @lazySingleton
  AuthInterceptor get authInterceptor => AuthInterceptor(
      () async => (await getIt<AuthReader>().authInfo)?.accessToken);

  @lazySingleton
  RetryInterceptor get retryInterceptor =>
      RetryInterceptor(dio: getIt<DioClient>().dio);

  @injectable
  void addInterceptors(
      AuthInterceptor authInterceptor, RetryInterceptor retryInterceptor) {
    dioClient.dio.interceptors.addAll([authInterceptor, retryInterceptor]);
  }
}
