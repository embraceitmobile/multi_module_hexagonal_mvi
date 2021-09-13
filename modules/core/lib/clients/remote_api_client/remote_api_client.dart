import 'package:core/models/network/base_response.dart';
import 'package:dio/dio.dart';

import 'base/i_remote_api_client.dart';
import 'base/network_configs.dart';

class RemoteApiClient
    with RemoteApiClientMixin<BaseResponse>
    implements IRemoteApiClient<BaseResponse> {
  final Dio dio;
  final NetworkConfigs networkConfigs;

  RemoteApiClient(this.dio, this.networkConfigs);
}
