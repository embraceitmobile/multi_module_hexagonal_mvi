import 'dart:async';
import 'package:async/async.dart';
import 'package:core/models/basic/basic_types.dart';

import '../models/resource/resource.dart';

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

  /// Additional watchable resources that should be merged into [resourceWatcher].
  /// Whenever a new event is emitted in any [resourceWatchers], the corresponding
  /// event is passed onto the [resourceWatcher].
  final List<Stream<Resource<T>>> resourceWatchers;

  /// Listen to this [Stream] to observe the changes in the [NetworkBoundResource]
  /// data [T]. It will emit new events whenever there is a change in the [Resource]
  /// of the remoteDataSource stream [_remoteStreamController] or the [resourceWatchers]
  /// if it is provided.
  late final Stream<Resource<T>> resourceWatcher;

  /// Controls the events for the [onFetchRemoteData] and [fetchOnceFromRemoteDatasource].
  late final StreamController<Resource<T>> _remoteStreamController;

  NetworkBoundResource({
    required this.shouldFetch,
    required this.onFetchLocalData,
    required this.onFetchRemoteData,
    required this.onSaveResultToLocal,
    this.resourceWatchers = const [],
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

    resourceWatcher = StreamGroup.mergeBroadcast([
      _remoteStreamController.stream,
      if (resourceWatchers.isNotEmpty) ...resourceWatchers,
    ]);
  }

  factory NetworkBoundResource.withLocalDatasource({
    required AsyncValueGetter<bool> shouldFetch,
    required AsyncValueGetter<T?> onFetchLocalData,
    required AsyncValueGetter<T?> onFetchRemoteData,
    required AsyncValueSetter<T> onSaveResultToLocal,
    required Stream<Resource<T>> localDatasourceWatcher,
  }) =>
      NetworkBoundResource(
          shouldFetch: shouldFetch,
          onFetchLocalData: onFetchLocalData,
          onFetchRemoteData: onFetchRemoteData,
          onSaveResultToLocal: onSaveResultToLocal,
          resourceWatchers: [localDatasourceWatcher]);

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
  Stream<Resource<T>> get toDataStateStream => this.asyncMap(
      (event) => event == null ? Resource.nothing() : Resource.success(event));
}
