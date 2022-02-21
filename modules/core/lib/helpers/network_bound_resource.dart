import 'dart:async';

import 'package:async/async.dart';
import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class NetworkBoundResource<T> {
  static const TAG = "NetworkBoundResource";

  /// Called with the data in the database to decide whether it should be
  /// fetched from the network
  final AsyncValueGetter<bool> shouldFetch;

  /// Called to get the cached data [T] from the database
  final AsyncValueGetter<T?> onFetchCachedData;

  /// Called to create the API call
  final AsyncValueGetter<T?> onFetchFromRemoteDatasource;

  /// Called to save the result [T] of the API response into the database
  final AsyncValueSetter<T> onSaveResultToCache;

  /// A [Stream] to observe the changes in the local data
  /// To convert a [Stream] of [T] to a [Stream] of [DataState] of [T], you can
  /// use the simple extension method [StreamTransformer.toDataStateStream] or
  /// write you own custom transformer.
  final Stream<DataState<T>>? localDatasourceListener;

  /// Listen to this [Stream] to observe the changes in the [NetworkBoundResource]
  /// data [T]. It will emit new events whenever there is a change in the [DataState]
  /// of the remoteDataSource stream [_remoteStreamController] or the [localDatasourceListener]
  /// if it is provided.
  late final Stream<DataState<T>> dataListener;

  /// Controls the events for the [onFetchFromRemoteDatasource] and [fetchOnceFromRemoteDatasource].
  late final StreamController<DataState<T>> _remoteStreamController;

  NetworkBoundResource({
    required this.shouldFetch,
    required this.onFetchCachedData,
    required this.onFetchFromRemoteDatasource,
    required this.onSaveResultToCache,
    this.localDatasourceListener,
  }) {
    _remoteStreamController = StreamController<DataState<T>>.broadcast(
      onListen: () async {
        try {
          await fetch();
        } catch (e) {
          print(
              "[$TAG] Received the following error when trying to fetch for the first time. \n$e");
        }
      },
    );

    dataListener = StreamGroup.mergeBroadcast([
      _remoteStreamController.stream,
      if (localDatasourceListener != null) localDatasourceListener!,
    ]);
  }

  Future<T?> fetch({bool alwaysFetchFreshData = false}) async {
    if (!alwaysFetchFreshData) {
      try {
        final cachedData = await onFetchCachedData();
        if (cachedData != null) return cachedData;
      } catch (e) {
        print(
            "[$TAG] Unable to fetch from cache, trying to fetch from remote datasource");
      }
    }

    if (!(await shouldFetch())) {
      print("[$TAG] shouldFetch = false, not fetching fresh data");
      return null;
    }

    try {
      _remoteStreamController.sink.add(DataState.loading());
      final freshData = await onFetchFromRemoteDatasource();
      if (freshData != null) {
        await onSaveResultToCache(freshData);
        return freshData;
      }
    } on Exception catch (e) {
      _remoteStreamController.sink.add(DataState.error(e));
      rethrow;
    }

    return null;
  }

  /// Call if you have alternate API or secondary params to fetch the data once
  Future<T?> fetchOnceFromRemoteDatasource(
      AsyncValueGetter<T?> networkCall) async {
    try {
      _remoteStreamController.sink.add(DataState.loading());
      final data = await networkCall();
      if (data != null) {
        await onSaveResultToCache(data);
        return data;
      }
    } on Exception catch (e) {
      _remoteStreamController.sink.add(DataState.error(e));
      rethrow;
    }

    return null;
  }

  Future<void> dispose() async {
    try {
      await _remoteStreamController.close();
    } catch (_) {
      rethrow;
    }
  }
}

extension StreamTransformer<T> on Stream<T?> {
  Stream<DataState<T>> get toDataStateStream => this.asyncMap((event) =>
      event == null ? DataState.nothing() : DataState.success(event));
}
