import 'package:dio/dio.dart';

class KillSwitchInterceptor extends Interceptor {
  final VoidCallback? onKillSwitch;

  KillSwitchInterceptor(this.onKillSwitch);

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    if (error.response?.statusCode != 451) {
      handler.next(error);
      return;
    }

    if (onKillSwitch != null) onKillSwitch!();
    handler.reject(error);
  }
}
