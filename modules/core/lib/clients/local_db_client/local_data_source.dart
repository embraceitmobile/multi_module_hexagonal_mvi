import 'dart:async';

import 'package:core/clients/local_db_client/sembast_client.dart';
import 'package:sembast/sembast.dart';

import 'base/dto.dart';
import 'base/i_local_datasource.dart';
import 'base/i_local_db_client.dart';
import 'base/models.dart';

typedef Mapper<T> = T Function(Map<String, dynamic>);

class LocalDataSource<T> implements ILocalDataSource<T> {
  ///[database] this is the sembast instance to be provided using Dependency Injection
  final SembastDbClient _dbClient;

  /// The [mapper] should be provided a function that accepts a Map<String, dynamic>
  /// and returns an instance of type [T]
  final Mapper<T> mapper;

  /// [store] is instantiated using the provided [storeName]
  final StoreRef store;

  ///[tag] is used to print logging info
  final String tag;

  /// Set [_shouldLog] to true to print the result of the db operations
  final bool _shouldLog;

  LocalDataSource(
      {required ILocalDbClient dbClient,
      required this.mapper,
      required String storeName,
      bool enableLogging = true})
      : _dbClient = dbClient as SembastDbClient,
        store = stringMapStoreFactory.store(storeName),
        _shouldLog = enableLogging,
        tag = storeName;

  /// Insert a single [item] into database
  /// returns count of items inserted
  Future<void> insert(LocalDto item) => _insertOrUpdate(item);

  /// Updates the [item] if it exists in the database
  /// returns the count of the [itemsWithQuantity] updated
  Future<void> update(LocalDto item) => _insertOrUpdate(item);

  /// Insert an [item] if it does not exist in database, otherwise update the [item]
  /// returns count of items inserted or updated
  Future<void> insertOrUpdate(LocalDto item) => _insertOrUpdate(item);

  Future<void> _insertOrUpdate(LocalDto item, {bool log = true}) async {
    if (_shouldLog && log) print("[$tag] [insert], insert item: ${item.pk}");

    try {
      await store.record(item.pk).put(_dbClient.database, item.toDtoMap());
    } catch (_) {
      rethrow;
    }
  }

  /// Insert or Update multiple [items] in the database
  /// returns true if all operations are completed successfully.
  Future<void> insertOrUpdateMany(List<LocalDto> items) async {
    if (_shouldLog)
      print(
          "[$tag] [insertOrUpdateMany], inserting ${items.length} items in db");

    try {
      await _dbClient.database.transaction((txn) async {
        for (final item in items) {
          await _insertOrUpdate(item, log: false);
        }
      });
    } catch (_) {
      rethrow;
    }
  }

  /// Insert multiple [items] into database
  /// returns count of items inserted
  Future<void> insertMany(List<LocalDto> items) => insertOrUpdateMany(items);

  /// Return the count of records in the database
  Future<int> count() async {
    if (_shouldLog) print("[$tag] [count], getting count from db");
    return await store.count(_dbClient.database);
  }

  /// Returns the items matching the [uniqueIds]
  /// returns a list of items of the type [T]
  Future<List<T>> getEntitiesById(List<String> uniqueIds) async {
    try {
      return (await store.records(uniqueIds).get(_dbClient.database))
          .map((result) => result as T)
          .toList(growable: false);
    } catch (_) {
      rethrow;
    }
  }

  /// Returns the items matching the provided [filter]
  /// To get all the items set filter to null
  /// returns a list of items of the type [T]
  Future<List<T>> find({Filter? filter}) async {
    // fetching data
    final recordSnapshots =
        await store.find(_dbClient.database, finder: Finder(filter: filter));

    if (recordSnapshots.isNotEmpty)
      return recordSnapshots.map((snapshot) => mapper(snapshot.value)).toList();
    else
      return [];
  }

  /// Remove an item from the database matching the given [filter]
  /// returns count of the [itemsWithQuantity] removed
  Future<void> delete(Filter filter) async {
    final finder = Finder(filter: filter);
    await store.delete(_dbClient.database, finder: finder);
  }

  /// Remove an item from the database matching the given [uniqueId].
  /// returns true if all operations are completed successfully.
  Future<void> deleteById(String uniqueId) async {
    return await store.record(uniqueId).delete(_dbClient.database);
  }

  /// Remove an item from the database matching the given [filters].
  /// returns true if all operations are completed successfully.
  Future<void> deleteAll(List<String> uniqueIds) async {
    try {
      await _dbClient.database.transaction((txn) async {
        for (final id in uniqueIds) {
          await deleteById(id);
        }
      });
    } catch (_) {
      rethrow;
    }
  }

  /// Clears the database of all the entries
  /// returns count of the [itemsWithQuantity] removed
  Future<int> clear() async {
    return await store.delete(_dbClient.database);
  }

  /// Listen to the changes in the db using the provided query given in [filter]
  /// returns a [Stream] of [T] as [Stream<T?>] that can be null.
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<T?> observeChange({Filter? filter}) {
    final query = store.query(finder: Finder(filter: filter));
    return query
        .onSnapshot(_dbClient.database)
        .map((snapshot) => snapshot == null ? null : mapper(snapshot.value));
  }

  /// Listen to the changes in the db using the provided query given in [filter]
  /// returns a [Stream] of [List] of [T] as [Stream<List<T>>].
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<List<T>> observeChanges({Filter? filter}) {
    final query = store.query(finder: Finder(filter: filter));
    return query.onSnapshots(_dbClient.database).map((snapshots) =>
        snapshots.map((snapshot) => mapper(snapshot.value)).toList());
  }
}
