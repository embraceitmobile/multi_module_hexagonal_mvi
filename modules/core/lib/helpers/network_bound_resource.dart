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
  final AsyncValueGetter<T?> onFetchLocalData;

  /// Called to create the API call
  final AsyncValueGetter<T?> onFetchRemoteData;

  /// Called to save the result [T] of the API response into the database
  final AsyncValueSetter<T> onSaveResultToLocal;

  /// A [Stream] to observe the changes in the local data
  /// To convert a [Stream] of [T] to a [Stream] of [Resource] of [T], you can
  /// use the simple extension method [StreamTransformer.toDataStateStream] or
  /// write you own custom transformer.
  final Stream<Resource<T>>? localDataSourceObservable;

  /// Listen to this [Stream] to observe the changes in the [NetworkBoundResource]
  /// data [T]. It will emit new events whenever there is a change in the [Resource]
  /// of the remoteDataSource stream [_remoteStreamController] or the [localDataSourceObservable]
  /// if it is provided.
  late final Stream<Resource<T>> dataListener;

  /// Controls the events for the [onFetchRemoteData] and [fetchOnceFromRemoteDatasource].
  late final StreamController<Resource<T>> _remoteStreamController;

  NetworkBoundResource({
    required this.shouldFetch,
    required this.onFetchLocalData,
    required this.onFetchRemoteData,
    required this.onSaveResultToLocal,
    this.localDataSourceObservable,
  }) {
    _remoteStreamController = StreamController<Resource<T>>.broadcast(
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
      if (localDataSourceObservable != null) localDataSourceObservable!,
    ]);
  }

  Future<T?> fetch({bool alwaysFetchFreshData = false}) async {
    if (!alwaysFetchFreshData) {
      try {
        final cachedData = await onFetchLocalData();
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
      _remoteStreamController.sink.add(Resource.loading());
      final freshData = await onFetchRemoteData();
      if (freshData != null) {
        await onSaveResultToLocal(freshData);
        return freshData;
      }
    } on Exception catch (e) {
      _remoteStreamController.sink.add(Resource.error(e));
      rethrow;
    }

    return null;
  }

  /// Call if you have alternate API or secondary params to fetch the data once
  Future<T?> fetchOnceFromRemoteDatasource(
      AsyncValueGetter<T?> networkCall) async {
    try {
      _remoteStreamController.sink.add(Resource.loading());
      final data = await networkCall();
      if (data != null) {
        await onSaveResultToLocal(data);
        return data;
      }
    } on Exception catch (e) {
      _remoteStreamController.sink.add(Resource.error(e));
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

/// Extension to convert a simple [Stream] into a [Resource] stream
extension StreamTransformer<T> on Stream<T?> {

  Stream<Resource<T>> get toDataStateStream => this.asyncMap((event) =>
      event == null ? Resource.nothing() : Resource.success(event));
}
