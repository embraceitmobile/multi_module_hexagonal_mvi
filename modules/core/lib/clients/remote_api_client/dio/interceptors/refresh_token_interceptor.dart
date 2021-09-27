import 'package:cubivue_utils/basic_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class RefreshTokenInterceptor extends Interceptor {
  static const TAG = "RefreshTokenInterceptor";

  final Dio dio;
  final String baseUrl;
  final Future<String?> accessToken;
  final Future<String?> refreshToken;
  final ValueSetter<String>? onNewAccessToken;
  final ValueSetter<String>? onNewRefreshToken;

  static String refreshTokenApi(String baseUrl) =>
      '${baseUrl}api/TokenAuth/RefreshToken';

  RefreshTokenInterceptor({
    required this.dio,
    required this.baseUrl,
    required this.accessToken,
    required this.refreshToken,
    required this.onNewAccessToken,
    required this.onNewRefreshToken,
  });

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    if ((await accessToken) == null || (await refreshToken) == null) {
      handler.next(err);
      return;
    }

    var options = err.response!.requestOptions;
    // update token and repeat
    // Lock to block the incoming request until the token updated
    dio.lock();
    dio.interceptors.responseLock.lock();
    dio.interceptors.errorLock.lock();
    await Dio()
        .post(refreshTokenApi(await baseUrl), data: {
          "accessToken": await accessToken,
          "refreshToken": await refreshToken
        })
        .then((res) => BaseResponse.fromMap(res.data))
        .then((response) => AuthResponse.fromMap(response.result))
        .then((response) async {
          if (onNewAccessToken != null) onNewAccessToken!(response.accessToken);
          if (onNewRefreshToken != null)
            onNewRefreshToken!(response.refreshToken);
          options.headers[AppHeaders.AUTHORIZATION] =
              'Bearer ${response.accessToken}';
          return true;
        })
        .catchError((error) {
          LogUtils.logError(
              TAG, "_refreshToken", "token refresh failed", error);
          return false;
        })
        .whenComplete(() {
          dio.unlock();
          dio.interceptors.responseLock.unlock();
          dio.interceptors.errorLock.unlock();
        })
        .then((e) {
          //repeat
          dio.fetch(options).then(
            (r) => handler.resolve(r),
            onError: (e) {
              handler.reject(e);
            },
          );
        });
    handler.next(err);
    return;
  }
}
