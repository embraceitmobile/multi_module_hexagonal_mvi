import 'dart:io';

import 'package:core/clients/remote_api_client/base/network_configs.dart';
import 'package:core/clients/remote_api_client/constants/app_headers.dart';
import 'package:cubivue_utils/basic_utils.dart' as utils show DateUtils;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'interceptors/kill_switch_interceptor.dart';
import 'interceptors/refresh_token_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

const _kDefaultReceiveTimeout = 10000;
const _kDefaultConnectionTimeout = 10000;
const _kDefaultRetryAttempts = 3;
const _kDefaultRetryInterval = Duration(seconds: 1);

class DioConfigs {
  final int receiveTimeout;
  final int connectionTimeout;
  final int retryAttempts;
  final Duration retryInterval;

  const DioConfigs({
    this.receiveTimeout = _kDefaultReceiveTimeout,
    this.connectionTimeout = _kDefaultConnectionTimeout,
    this.retryAttempts = _kDefaultRetryAttempts,
    this.retryInterval = _kDefaultRetryInterval,
  });
}

class DioClient {
  static const TAG = "DioClient";

  final NetworkConfigs networkConfigs;
  final VoidCallback? onKillSwitch;
  final DioConfigs dioConfigs;
  final ValueSetter<String>? onNewAccessToken;
  final ValueSetter<String>? onNewRefreshToken;
  final Dio _dioClient;

  DioClient(this.networkConfigs,
      {this.onKillSwitch,
      this.onNewAccessToken,
      this.onNewRefreshToken,
      this.dioConfigs = const DioConfigs()})
      : _dioClient = _createDio(
          networkConfigs: networkConfigs,
          dioConfigs: dioConfigs,
          onNewAccessToken: onNewAccessToken,
          onNewRefreshToken: onNewRefreshToken,
          onKillSwitch: onKillSwitch,
        );

  Dio get dio => _dioClient;

  static Dio _createDio({
    required NetworkConfigs networkConfigs,
    required DioConfigs dioConfigs,
    ValueSetter<String>? onNewAccessToken,
    ValueSetter<String>? onNewRefreshToken,
    VoidCallback? onKillSwitch,
  }) {
    final dio = Dio();

    dio
      ..options.connectTimeout = dioConfigs.connectionTimeout
      ..options.receiveTimeout = dioConfigs.receiveTimeout
      ..interceptors.addAll([
        RetryInterceptor(
          dio: dio,
          options: RetryOptions(
            retries: dioConfigs.retryAttempts,
            retryInterval: dioConfigs.retryInterval,
          ),
        ),
        LogInterceptor(
          request: true,
          responseBody: true,
          requestBody: true,
        ),
        KillSwitchInterceptor(onKillSwitch),
        RefreshTokenInterceptor(
            dio: dio,
            baseUrl: networkConfigs.baseUrl,
            accessToken: networkConfigs.accessToken,
            refreshToken: networkConfigs.refreshToken,
            onNewAccessToken: onNewAccessToken,
            onNewRefreshToken: onNewRefreshToken),
        InterceptorsWrapper(onRequest: (options, handler) async {
          _setupHeaders(
            options.headers,
            accessToken: await networkConfigs.accessToken,
            serverDeviceId: await networkConfigs.serverDeviceId,
            organizationUnitId: await networkConfigs.organizationUnitId,
            tenantId: await networkConfigs.tenantId,
          );

          print("*** api: [${options.uri.toString()}]\n"
              "*** method: [${options.method}]\n"
              "*** request body: [${options.data.toString()}]\n"
              "*** headers: ");
          options.headers.forEach((key, value) {
            print("*** $key: $value");
          });
          handler.next(options);

          // LogUtils.logNetworkInfo(NetworkInfo(
          //     sending: true,
          //     url: options.uri.toString(),
          //     method: options.method,
          //     headers: options.headers.toString(),
          //     requestBody: options.data.toString(),
          //     responseBody: ""));
        }, onResponse: (response, handler) {
          print("*** api: [${response.requestOptions.uri.toString()}]\n"
              "*** method: [${response.requestOptions.method}]\n"
              "*** request body: [${response.requestOptions.data.toString()}]\n"
              "*** response: [${response.data.toString()}]");
          // LogUtils.logNetworkInfo(NetworkInfo(
          //     sending: false,
          //     url: response.requestOptions.uri.toString(),
          //     method: response.requestOptions.method,
          //     headers: response.requestOptions.headers.toString(),
          //     requestBody: response.requestOptions.data.toString(),
          //     responseBody: response.data.toString()));
          handler.next(response);
        }, onError: (error, handler) async {
          print("*** api: [${error.requestOptions.uri.toString()}]\n"
              "*** method: [${error.requestOptions.method}]\n"
              "*** request body: [${error.requestOptions.data.toString()}]\n"
              "*** error response: [${error.error}]\n"
              "*** error message: ${error.message}");
          // LogUtils.logInfo("$TAG", "onError",
          //     "[uri: ${error.requestOptions.uri}]\n"
          //         "[error: ${error.error}\n"
          //         "[message: ${error.message}]\n"
          //         "[stackTrace: ${error.message}]");
          handler.next(error);
        }),
      ]);

    return dio;
  }

  static Map<String, dynamic> _setupHeaders(
    Map<String, dynamic> requestHeaders, {
    String? accessToken,
    int? serverDeviceId,
    int? tenantId,
    int? organizationUnitId,
  }) {
    // setting access token
    if (accessToken != null) {
      requestHeaders.putIfAbsent(
          AppHeaders.AUTHORIZATION, () => 'Bearer $accessToken');
    }

    // setting device id
    if (serverDeviceId != null) {
      requestHeaders.putIfAbsent(AppHeaders.DEVICE_ID, () => serverDeviceId);
    }

    // setting tenant id e.g. BK, SS, DAO etc
    if (tenantId != null) {
      requestHeaders.putIfAbsent(AppHeaders.TENANT_ID, () => tenantId);
    }

    // setting organization unit id
    if (organizationUnitId != null) {
      requestHeaders.putIfAbsent(
          AppHeaders.ORGANIZATION_UNIT_ID, () => organizationUnitId);
    }

    requestHeaders.putIfAbsent(
        AppHeaders.TIMESTAMP, () => utils.DateUtils.timeStampUtcIso8601);

    requestHeaders.putIfAbsent(
        AppHeaders.TIMEZONE_OFFSET, () => utils.DateUtils.timeZoneOffset);

    requestHeaders.putIfAbsent(
        AppHeaders.PLATFORM, () => Platform.isIOS ? 'iOS' : 'Android');

    return requestHeaders;
  }
}
