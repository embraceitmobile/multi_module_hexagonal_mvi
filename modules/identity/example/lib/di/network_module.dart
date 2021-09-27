import 'package:core/clients/remote_api_client/dio/dio_client.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  NetworkModule();

  // DI Providers:--------------------------------------------------------------
  @singleton
  DioClient get dio => DioClient(baseUrl: "www.someweburl.com");

  @singleton
  IRemoteApiClient<BaseResponse> get provideNetworkApiClient =>
      RemoteApiClient(getIt<DioClient>().dio);
}
