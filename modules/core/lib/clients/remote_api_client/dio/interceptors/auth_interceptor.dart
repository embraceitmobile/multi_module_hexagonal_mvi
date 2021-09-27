import 'package:core/core.dart';

class AuthInterceptor extends Interceptor {
  final String? accessToken;

  AuthInterceptor(this.accessToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (accessToken != null)
      options.headers.putIfAbsent("Authorization", () => 'Bearer $accessToken');

    super.onRequest(options, handler);
  }
}
