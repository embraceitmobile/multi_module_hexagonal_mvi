import 'package:dio/dio.dart';

const _kDefaultReceiveTimeout = 10000;
const _kDefaultConnectionTimeout = 10000;

class DioConfigs {
  final int receiveTimeout;
  final int connectionTimeout;

  const DioConfigs({
    this.receiveTimeout = _kDefaultReceiveTimeout,
    this.connectionTimeout = _kDefaultConnectionTimeout,
  });
}

class DioClient {
  final DioConfigs dioConfigs;
  final Dio _dio;

  DioClient({String? baseUrl, this.dioConfigs = const DioConfigs()})
      : _dio = Dio()
          ..options.baseUrl = baseUrl ?? ""
          ..options.connectTimeout = dioConfigs.connectionTimeout
          ..options.receiveTimeout = dioConfigs.receiveTimeout;

  Dio get dio => _dio;

  Dio addInterceptors(Iterable<Interceptor> interceptors) {
    return _dio..interceptors.addAll(interceptors);
  }
}
