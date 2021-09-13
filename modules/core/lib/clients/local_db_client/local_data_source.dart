import 'dart:async';

import 'package:core/clients/local_db_client/sembast_client.dart';
import 'package:cubivue_utils/basic_utils.dart';
import 'package:sembast/sembast.dart';

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

  ///[tag] is used to logInfo using [LogUtils]
  final String tag;

  LocalDataSource(
      {required ILocalDbClient dbClient,
      required this.mapper,
      required String storeName})
      : _dbClient = dbClient as SembastDbClient,
        store = intMapStoreFactory.store(storeName),
        tag = storeName;

  /// Insert a single [item] into database
  /// returns count of items inserted
  Future<int> insert(Entity item) async => _insert(item);

  Future<int> _insert(Entity item, {bool log = true}) async {
    if (log) LogUtils.logInfo(tag, "insert", "insert item: ${item.uniqueKey}");
    return await store.add(_dbClient.database, item.toEntityMap()) as int;
  }

  /// Insert a single [item] with key into database
  Future<int> insertWithKey(Entity item) async => _insertWithKey(item);

  Future<int> _insertWithKey(Entity item, {bool log = true}) async {
    if (log)
      LogUtils.logInfo(
          tag, "insert", "insert with key item: ${item.uniqueKey}");
    return await store
        .record(int.parse(item.uniqueKey))
        .add(_dbClient.database, item.toEntityMap()) as int;
  }

  /// Update a single [item] with key into database
  Future<int> updateWithKey(Entity item) async => _updateWithKey(item);

  Future<int> _updateWithKey(Entity item, {bool log = true}) async {
    if (log)
      LogUtils.logInfo(
          tag, "update", "update with key item: ${item.uniqueKey}");
    return await store.update(_dbClient.database, item.toEntityMap(),
        finder: Finder(filter: Filter.byKey(int.parse(item.uniqueKey))));
  }

  /// Updates the [item] if it exists in the database
  /// returns the count of the [itemsWithQuantity] updated
  Future<int> update(Entity item) async => _update(item);

  Future<int> _update(Entity item, {bool log = true}) async {
    if (log)
      LogUtils.logInfo(tag, "update", "updating item to db, ${item.uniqueKey}");

    return await store.update(_dbClient.database, item.toEntityMap(),
        finder: Finder(filter: DbFilters.byUniqueId(item.uniqueKey)));
  }

  /// Insert an [item] if it does not exist in database, otherwise update the [item]
  /// returns count of items inserted or updated
  Future<int> insertOrUpdate(Entity item) async => _insertOrUpdate(item);

  Future<int> _insertOrUpdate(Entity item, {bool log = true}) async {
    if (log)
      LogUtils.logInfo(tag, "insertOrUpdate",
          "insertOrUpdate item to db, ${item.uniqueKey}");
    return await find(filter: DbFilters.byUniqueId(item.uniqueKey)).then(
        (list) =>
            list.isEmpty ? _insert(item, log: log) : _update(item, log: log));
  }

  /// Insert multiple [items] into database
  /// returns count of items inserted
  Future<List<int>> insertMany(List<Entity> items) async {
    LogUtils.logInfo(
        tag, "insertMany", "inserting ${items.length} items in db");

    return store.addAll(_dbClient.database,
            items.map((item) => item.toEntityMap()).toList())
        as FutureOr<List<int>>;
  }

  /// Insert or Update multiple [items] in the database
  /// returns true if all operations are completed successfully.
  Future<bool> insertOrUpdateMany(List<Entity> items) async {
    LogUtils.logInfo(
        tag, "insertMany", "insertOrUpdateMany ${items.length} items in db");
    return await Future.forEach(items,
            (dynamic item) async => await _insertOrUpdate(item, log: false))
        .then((_) => true);
  }

  /// Return the count of records in the database
  Future<int> count() async {
    LogUtils.logInfo(tag, "count", "getting count from db");
    return await store.count(_dbClient.database);
  }

  /// Returns the items matching the [uniqueIds]
  /// returns a list of items of the type [T]
  Future<List<T>> getEntitiesById(List<String> uniqueIds) async {
    return find(filter: DbFilters.byUniqueIds(uniqueIds));
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

  /// Returns the item matching the provided [filter]
  /// To get all the items set filter to null
  /// returns a list of items of the type [T]
  Future<T?> findById({Filter? filter}) async {
    final recordSnapshots =
        await store.find(_dbClient.database, finder: Finder(filter: filter));
    if (recordSnapshots.isNotEmpty) {
      return recordSnapshots
          .map((snapshot) => mapper(snapshot.value))
          .toList()
          .first;
    } else
      return null;
  }

  /// Remove an item from the database matching the given [filter]
  /// returns count of the [itemsWithQuantity] removed
  Future<int> delete(Filter filter) async {
    final finder = Finder(filter: filter);
    return await store.delete(_dbClient.database, finder: finder);
  }

  /// Remove an item from the database matching the given [uniqueId].
  /// returns true if all operations are completed successfully.
  Future<int> deleteById(String uniqueId) async {
    final finder = Finder(filter: Filter.equals(Entity.unique_key, uniqueId));
    return await store.delete(_dbClient.database, finder: finder);
  }

  /// Remove an item from the database matching the given [filters].
  /// returns true if all operations are completed successfully.
  Future<int> deleteAll(List<String> uniqueIds) async {
    final finder = Finder(filter: DbFilters.byUniqueIds(uniqueIds));
    return await store.delete(_dbClient.database, finder: finder);
  }

  /// Remove an item from the database matching the given [filters].
  /// returns true if all operations are completed successfully.
  Future<int> deleteAllById(List<String> uniqueIds) async {
    final finder = Finder(filter: DbFilters.byUniqueIds(uniqueIds));
    return await store.delete(_dbClient.database, finder: finder);
  }

  /// Clears the database of all the entries
  /// returns count of the [itemsWithQuantity] removed
  Future<int> clear() async {
    return await store.delete(_dbClient.database);
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