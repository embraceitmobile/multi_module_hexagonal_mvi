import 'package:core/core_pure_dart.dart';

class AuthInterceptor extends Interceptor {
  final AsyncValueGetter<String?> accessToken;

  AuthInterceptor(this.accessToken);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (await accessToken() != null)
      options.headers
          .putIfAbsent("Authorization", () => 'Bearer ${accessToken()}');

    super.onRequest(options, handler);
  }
}
