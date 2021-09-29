import 'dart:convert';

import 'package:core/core.dart';
import 'package:identity/repository/auth/datasources/remote/apis/change_password_api.dart';
import 'package:identity/repository/auth/datasources/remote/apis/login_api.dart';
import 'package:identity/repository/auth/datasources/remote/apis/logout_api.dart';
import 'package:injectable/injectable.dart';

import 'i_auth_remote_datasource.dart';

@Singleton(as: IAuthRemoteDatasource)
class AuthMockRemoteDatasource implements IAuthRemoteDatasource {
  static const String TAG = "AuthMockApiImplementation";

  const AuthMockRemoteDatasource(IRemoteApiClient<dynamic> apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (request.userNameOrEmailAddress == "user" &&
        request.password == "1234") {
      return LoginResponse.fromMap(jsonDecode(_loginResponse));
    } else {
      throw NetworkException(ErrorResponse(
        message: "The username or password is not correct",
        statusCode: 401,
      ));
    }
  }

  Future<LogoutResponse> logout() async {
    await Future.delayed(Duration(milliseconds: 500));
    throw UnimplementedError();
  }

  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest request) async {
    await Future.delayed(Duration(milliseconds: 500));
    return ChangePasswordResponse.response(true);
  }
}

const _loginResponse = r"""
{
    "accessToken": "x4fsTh47ciPWlypxc0ekKYB6eryReeeQfwblLyKuy1r_vCk6URY_4-1UPtVHD3XDChd3Tr2LyIjc17F-4-NevzzmkX7yciybk49VlRuTkm2Z2aTJOko-LNcYMXk1lGXGaLEZYW_sjhQXg8ySdqeT7O-E4uCipzq8i8lx84JXDC-n_M8XK6YHhY0JJ_HfhiAEVqMFaizaRM95kUoqTQmZjxCzFv4eFknJKST1oQ3zSkoGqisNEO760PXbj5Ah6WQspTlNI77uhgDqq0SItTJMV8Nxk9iIK7deH3uYK_qmikdNBKDnY4QBFI98qdp_lVDgj6gqGjaC2R9hOWSXDnZHkSF9ECESlsFcGvkKTmHbh0ryitfeEbqcxMR0DY_ztifbpEOJy5ovBtpzMfMCC0XzkGgvhkKHqA4mw-tEVAquomQmvb9sc7HDRJVxcsPPAKlpvgVl6ZQb27m3R8BRteZH7c9pyU6jJRSa3jMAFn47q5Z3nYA9pMXF7KTEO-cNyrLPPuqzmmGxMVpAPwZ0N0T-UaBdvJ8mL1YEsD3y5PATPPmnpSSIMTp6XecHLhzg6rxlAJ3jp1JNruxM4ItMwenOY6yfpDDGYbHc2svnhzrRwb2NEg2TeQRginTJ8hC2__dyspW9WbobuA-1qN5N0osMbg",
    "tokenType": "bearer",
    "expireInSeconds": 28799,
    "refreshToken": "120c65e2-f40a-42f4-a2b4-68170fbc49c4",
    "userId": 121
}
""";
