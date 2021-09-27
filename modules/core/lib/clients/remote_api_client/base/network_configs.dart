import 'package:flutter/foundation.dart';

class AuthConfigs {
  final AsyncValueGetter<String?> _accessToken;
  final AsyncValueGetter<String?> _refreshToken;

  AuthConfigs({
    required AsyncValueGetter<String?> accessToken,
    required AsyncValueGetter<String?> refreshToken,
  })  : this._accessToken = accessToken,
        this._refreshToken = refreshToken;

  Future<String?> get accessToken => _accessToken();

  Future<String?> get refreshToken => _refreshToken();
}
