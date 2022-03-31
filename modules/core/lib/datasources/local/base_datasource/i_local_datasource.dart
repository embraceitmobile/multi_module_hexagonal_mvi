import 'package:core/datasources/local/local_dto.dart';

abstract class ILocalDataSource<K, T extends LocalDto> {
  /// Insert a single [item] into database
  Future<void> insert(T object);

  /// Updates the [item] if it exists in the database
  Future<void> update(T object);

  /// Insert an [item] if it does not exist in database, otherwise update the [item]
  Future<void> insertOrUpdate(T object);

  /// Insert multiple [items] into database
  Future<void> insertMany(List<T> list);

  /// Insert or Update multiple [items] in the database
  Future<void> insertOrUpdateMany(List<T> list);

  /// Returns the items matching the provided [id]
  /// returns the object [T] if [id] exists, otherwise returns null
  Future<T?> find(K id);

  /// Returns the items matching the provided [id]
  /// returns a list of items of the type [T]
  Future<List<T>> findAll([List<K>? ids]);

  /// Remove an item from the database matching the given [id].
  Future<void> delete(K id);

  /// Remove all the entities matching the [ids] from the db
  Future<void> deleteAll(List<K> ids);

  /// Clears the database of all the entries
  Future<void> clear();

  /// Return the count of records in the database
  Future<int> count();

  /// Listen to the changes in the db when you are certain that only one result
  /// will be returned. If more than one result is expected, then use
  /// [observeChanges] instead.
  /// returns a [Stream] of [T] as [Stream<T?>] that can be null.
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<T?> observeChange();

  /// Listen to the changes in the db using the provided query given in [filter]
  /// returns a [Stream] of [List] of [T] as [Stream<List<T>>].
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<List<T>> observeChanges();
}
