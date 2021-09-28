import 'package:dio/dio.dart';

import 'base/i_remote_api_client.dart';

class RemoteApiClient
    with RemoteApiClientMixin<dynamic>
    implements IRemoteApiClient<dynamic> {
  final Dio dio;

  RemoteApiClient(this.dio);
}
