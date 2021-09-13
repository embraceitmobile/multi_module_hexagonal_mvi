import 'package:flutter/foundation.dart';

class NetworkConfigs {
  final AsyncValueGetter<String> _baseUrl;
  final AsyncValueGetter<int?> _serverDeviceId;
  final AsyncValueGetter<int?> _organizationUnitId;
  final AsyncValueGetter<int?> _tenantId;

  final AsyncValueGetter<String?> _accessToken;
  final AsyncValueGetter<String?> _refreshToken;

  NetworkConfigs({
    required AsyncValueGetter<String> baseUrl,
    required AsyncValueGetter<int?> serverDeviceId,
    required AsyncValueGetter<int?> organizationUnitId,
    required AsyncValueGetter<int?> tenantId,
    required AsyncValueGetter<String?> accessToken,
    required AsyncValueGetter<String?> refreshToken,
  })   : this._serverDeviceId = serverDeviceId,
        this._organizationUnitId = organizationUnitId,
        this._tenantId = tenantId,
        this._baseUrl = baseUrl,
        this._accessToken = accessToken,
        this._refreshToken = refreshToken;

  Future<int?> get serverDeviceId => _serverDeviceId();

  Future<int?> get organizationUnitId => _organizationUnitId();

  Future<int?> get tenantId => _tenantId();

  Future<String> get baseUrl => _baseUrl();

  Future<String?> get accessToken => _accessToken();

  Future<String?> get refreshToken => _refreshToken();
}