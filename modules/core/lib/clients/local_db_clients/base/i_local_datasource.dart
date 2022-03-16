import 'package:core/clients/local_db_clients/base/local_dto.dart';
import 'package:sembast/sembast.dart';

abstract class ILocalDataSource<T> {
  /// Insert a single [item] into database
  Future<void> insert(LocalDto object);

  /// Updates the [item] if it exists in the database
  Future<void> update(LocalDto object);

  /// Insert an [item] if it does not exist in database, otherwise update the [item]
  Future<void> insertOrUpdate(LocalDto object);

  /// Insert multiple [items] into database
  Future<void> insertMany(List<LocalDto> list);

  /// Insert or Update multiple [items] in the database
  Future<void> insertOrUpdateMany(List<LocalDto> list);

  /// Returns the items matching the provided [id]
  /// returns the object [T] if [id] exists, otherwise returns null
  Future<T?> find(String id);

  /// Returns the items matching the provided [id]
  /// returns a list of items of the type [T]
  Future<List<T>> findAll([List<String>? ids]);

  /// Remove an item from the database matching the given [id].
  Future<void> delete(String id);

  /// Remove all the entities matching the [ids] from the db
  Future<void> deleteAll(List<String> ids);

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
