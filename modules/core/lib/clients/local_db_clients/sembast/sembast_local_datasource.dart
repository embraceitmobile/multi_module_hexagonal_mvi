import 'dart:async';
import 'package:core/clients/local_db_clients/sembast/sembast_db_client.dart';
import 'package:core/clients/local_db_clients/sembast/sembast_dto.dart';
import 'package:core/datasources/local/base_datasource/i_local_datasource.dart';
import 'package:core/datasources/local/i_local_db_client.dart';
import 'package:sembast/sembast.dart';

class SembastBaseLocalDataSource<K, T extends SembastDto<K>>
    implements ILocalDataSource<K, T> {
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

  SembastBaseLocalDataSource(
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
  Future<void> insert(T item) => _insertOrUpdate(item);

  /// Updates the [item] if it exists in the database
  /// returns the count of the [itemsWithQuantity] updated
  Future<void> update(T item) => _insertOrUpdate(item);

  /// Insert an [item] if it does not exist in database, otherwise update the [item]
  /// returns count of items inserted or updated
  Future<void> insertOrUpdate(T item) => _insertOrUpdate(item);

  Future<void> _insertOrUpdate(T item, {bool log = true}) async {
    if (_shouldLog && log) print("[$tag] [insert], insert item: ${item.id}");

    try {
      await store.record(item.id).put(_dbClient.database, item.toDtoMap());
    } catch (_) {
      rethrow;
    }
  }

  /// Insert or Update multiple [items] in the database
  /// returns true if all operations are completed successfully.
  Future<void> insertOrUpdateMany(List<T> items) async {
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
  Future<void> insertMany(List<T> items) => insertOrUpdateMany(items);

  /// Return the count of records in the database
  Future<int> count() async {
    if (_shouldLog) print("[$tag] [count], getting count from db");
    return await store.count(_dbClient.database);
  }

  /// Returns the item matching the [id]
  Future<T?> find(K id) async {
    return store.record(id).get(_dbClient.database) as T;
  }

  /// Returns all the items in the db records
  Future<List<T>> findAll([List<K>? ids]) async {
    final results = ids != null
        ? await store.records(ids).get(_dbClient.database)
        : await store.find(_dbClient.database);

    return results.map((snapshot) => mapper(snapshot.value)).toList();
  }

  /// Remove an item from the database matching the given [id]
  Future<void> delete(K id) async {
    return await store.record(id).delete(_dbClient.database);
  }

  /// Remove an item from the database matching the given [filters].
  /// returns true if all operations are completed successfully.
  Future<void> deleteAll(List<K> uniqueIds) async {
    try {
      await _dbClient.database.transaction((txn) async {
        for (final id in uniqueIds) {
          await delete(id);
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

  /// Listen to the changes in the db when you are certain that only one result
  /// will be returned. If more than one result is expected, then use
  /// [observeChanges] instead.
  /// returns a [Stream] of [T] as [Stream<T?>] that can be null.
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<T?> observeChange() {
    final query = store.query();
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
    final query = store.query();
    return query.onSnapshots(_dbClient.database).map((snapshots) =>
        snapshots.map((snapshot) => mapper(snapshot.value)).toList());
  }
}
