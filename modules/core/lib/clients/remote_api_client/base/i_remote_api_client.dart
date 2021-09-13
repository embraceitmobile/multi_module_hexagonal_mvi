import 'package:dio/dio.dart';

import 'network_configs.dart';

abstract class IRemoteApiClient<T> {
  NetworkConfigs get networkConfigs;

  /// Handy method to make http GET request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> get(
    String endpoint, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  /// Handy method to make http POST request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> post(
    String endpoint, {
    String? baseUrl,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// Handy method to make http PUT request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> put(
    String endpoint, {
    String? baseUrl,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  /// Handy method to make http HEAD request, which is a alias of [dio.fetch(RequestOptions)].
  Future<T?> head(
    String endpoint, {
    String? baseUrl,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Handy method to make http DELETE request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> delete(
    String endpoint, {
    String? baseUrl,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Handy method to make http PATCH request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> patch(
    String endpoint, {
    String? baseUrl,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  });

  Future download(
    String endpoint,
    savePath, {
    String? baseUrl,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options,
  });
}

mixin RemoteApiClientMixin<T> implements IRemoteApiClient<T> {
  NetworkConfigs get networkConfigs;

  Dio get dio;

  Future<String> _fullUrl(String? baseUrl, String endpoint) async {
    var _baseUrl = baseUrl ?? await networkConfigs.baseUrl;
    if (!_baseUrl.endsWith("/")) _baseUrl = "$_baseUrl/";

    var _endpoint = endpoint.startsWith("/") ? endpoint.substring(1) : endpoint;
    if (_endpoint.endsWith("/"))
      _endpoint = _endpoint.substring(0, _endpoint.length);

    return "$_baseUrl$_endpoint";
  }

  Future<T?> get(String endpoint,
      {String? baseUrl,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.get(
        await _fullUrl(baseUrl, endpoint),
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<T?> post(String endpoint,
      {String? baseUrl,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.post(
        await _fullUrl(baseUrl, endpoint),
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<T?> put(String endpoint,
      {String? baseUrl,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.put(
        await _fullUrl(baseUrl, endpoint),
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<T?> delete(String endpoint,
      {String? baseUrl,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final Response<T> response = await dio.delete(
        await _fullUrl(baseUrl, endpoint),
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<T?> head(String endpoint,
      {String? baseUrl,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final Response<T> response = await dio.head(
        await _fullUrl(baseUrl, endpoint),
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future<T?> patch(String endpoint,
      {String? baseUrl,
      data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.patch(
        await _fullUrl(baseUrl, endpoint),
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data;
    } catch (_) {
      rethrow;
    }
  }

  Future download(
    String endpoint,
    savePath, {
    String? baseUrl,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    data,
    Options? options,
  }) async {
    try {
      final Response response = await dio.download(
        await _fullUrl(baseUrl, endpoint),
        savePath,
        onReceiveProgress: onReceiveProgress,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        data: data,
        options: options,
      );
      return response.data;
    } catch (_) {
      rethrow;
    }
  }
}
