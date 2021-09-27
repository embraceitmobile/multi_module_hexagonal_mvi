import 'package:core/clients/remote_api_client/base/network_configs.dart';
import 'package:core/clients/remote_api_client/dio/dio_client.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';

@module
abstract class NetworkModule {
  NetworkModule();

  // DI Providers:--------------------------------------------------------------
  @singleton
  IRemoteApiClient<BaseResponse> get provideNetworkApiClient {
    final provideNetworkConfigs = NetworkConfigs(
      baseUrl: () async => "baseUrl",
      serverDeviceId: () async => 0,
      tenantId: () async => 0,
      organizationUnitId: () async => 0,
      accessToken: () async => "accessToken",
      refreshToken: () async => "refreshToken",
    );

    final provideDioClient = DioClient(provideNetworkConfigs).dio;

    return RemoteApiClient(provideDioClient, provideNetworkConfigs);
  }
}
