import 'dart:math';

import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:identity/data/auth/datasources/remote/dtos/change_password_api.dart';
import 'package:identity/data/auth/datasources/remote/dtos/login_api.dart';
import 'package:identity/data/auth/datasources/remote/dtos/logout_api.dart';
import 'package:injectable/injectable.dart';

import 'i_auth_remote_datasource.dart';

@Singleton(as: IAuthRemoteDatasource)
class AuthRemoteDatasource implements IAuthRemoteDatasource {
  static const String TAG = "AuthApiImplementation";
  final IRemoteApiClient<dynamic> _apiClient;

  // injecting api client instance
  const AuthRemoteDatasource(this._apiClient);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _apiClient.get(loginEndpoint);

      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      final users = response as List<dynamic>;

      final user = users.firstWhereOrNull(
        (element) =>
            element["username"].toString().toLowerCase() ==
            request.username.toLowerCase(),
      );

      if (user == null) {
        throw NetworkException(ErrorResponse(
          statusCode: 401,
          message:
              "Username is not valid.\nHint: Try '${users[Random().nextInt(users.length)]["username"]}'",
        ));
      }

      if (request.password != "1234") {
        throw NetworkException(ErrorResponse(
          statusCode: 401,
          message: "Password is not correct.\nHint: Try '1234'",
        ));
      }

      return LoginResponse(
        accessToken:
            "x4fsTh47ciPWlypxc0ekKYB6eryReeeQfwblLyKuy1r_vCk6URY_4-1UPtVHD3XDChd3Tr2LyIjc17F-4-NevzzmkX7yciybk49VlRuTkm2Z2aTJOko-LNcYMXk1lGXGaLEZYW_sjhQXg8ySdqeT7O-E4uCipzq8i8lx84JXDC-n_M8XK6YHhY0JJ_HfhiAEVqMFaizaRM95kUoqTQmZjxCzFv4eFknJKST1oQ3zSkoGqisNEO760PXbj5Ah6WQspTlNI77uhgDqq0SItTJMV8Nxk9iIK7deH3uYK_qmikdNBKDnY4QBFI98qdp_lVDgj6gqGjaC2R9hOWSXDnZHkSF9ECESlsFcGvkKTmHbh0ryitfeEbqcxMR0DY_ztifbpEOJy5ovBtpzMfMCC0XzkGgvhkKHqA4mw-tEVAquomQmvb9sc7HDRJVxcsPPAKlpvgVl6ZQb27m3R8BRteZH7c9pyU6jJRSa3jMAFn47q5Z3nYA9pMXF7KTEO-cNyrLPPuqzmmGxMVpAPwZ0N0T-UaBdvJ8mL1YEsD3y5PATPPmnpSSIMTp6XecHLhzg6rxlAJ3jp1JNruxM4ItMwenOY6yfpDDGYbHc2svnhzrRwb2NEg2TeQRginTJ8hC2__dyspW9WbobuA-1qN5N0osMbg",
        refreshToken: "120c65e2-f40a-42f4-a2b4-68170fbc49c4",
        expireInSeconds: 28799,
        userId: user["id"],
      );
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  Future<LogoutResponse> logout() async {
    try {
      await Future.delayed(Duration(milliseconds: 500));

      return LogoutResponse(true);
    } on InvalidDataException {
      rethrow;
    } on NetworkException catch (ex) {
      if (ex.error.statusCode == 401)
        return LogoutResponse(true);
      else
        rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  Future<ChangePasswordResponse> changePassword(
      ChangePasswordRequest request) async {
    try {
      await Future.delayed(Duration(milliseconds: 500));

      return ChangePasswordResponse(true);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }
}
