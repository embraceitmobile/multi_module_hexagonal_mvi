import 'package:dio/dio.dart';

abstract class IRemoteApiClient<T> {
  /// Handy method to make http GET request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  /// Handy method to make http POST request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> post(
    String endpoint, {
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
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Handy method to make http DELETE request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> delete(
    String endpoint, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  });

  /// Handy method to make http PATCH request, which is a alias of  [dio.fetch(RequestOptions)].
  Future<T?> patch(
    String endpoint, {
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
  Dio get dio;

  Future<T?> get(String endpoint,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.get(
        endpoint,
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
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.post(
        endpoint,
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
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.put(
        endpoint,
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
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final Response<T> response = await dio.delete(
        endpoint,
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
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      final Response<T> response = await dio.head(
        endpoint,
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
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      onSendProgress,
      onReceiveProgress}) async {
    try {
      final Response<T> response = await dio.patch(
        endpoint,
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
        endpoint,
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
