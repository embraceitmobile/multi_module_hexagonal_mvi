import 'package:flutter/foundation.dart';

typedef RemoteCallBuilder<T> = Future<T?> Function(Future networkCall);

class NetworkBoundResource<T> {
  static const TAG = "NetworkBoundResource";

  ///Called with the data in the database to decide whether it should be
  ///fetched from the network
  final AsyncValueGetter<bool> shouldFetch;

  ///Called to get the cached data [T] from the database
  final AsyncValueGetter<T?> onFetchCachedData;

  ///Called to create the API call
  final AsyncValueGetter<T> onFetchFromRemoteDatasource;

  ///Called to save the result [T] of the API response into the database
  final AsyncValueSetter<T> onSaveResultToCache;

  const NetworkBoundResource({
    required this.shouldFetch,
    required this.onFetchCachedData,
    required this.onFetchFromRemoteDatasource,
    required this.onSaveResultToCache,
  });

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
      print("[$TAG] shouldFetch == false, not fetching fresh data");
      return null;
    }

    try {
      final freshData = await onFetchFromRemoteDatasource();
      if (freshData != null) {
        await onSaveResultToCache(freshData);
        return freshData;
      }
    } catch (e) {
      rethrow;
    }
  }

  ///Call if you have alternate API or secondary params to fetch the data
  Future<T?> fetchOnceFromRemoteDatasource(
      AsyncValueGetter<T?> networkCall) async {
    try {
      final data = await networkCall();
      if (data != null) {
        await onSaveResultToCache(data);
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
