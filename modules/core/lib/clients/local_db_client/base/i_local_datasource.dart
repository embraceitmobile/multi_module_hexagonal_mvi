import 'package:core/clients/local_db_client/base/dto.dart';
import 'package:sembast/sembast.dart';

abstract class ILocalDataSource<T> {
  /// Insert a single [item] into database
  Future<void> insert(LocalDto object);

  /// Updates the [item] if it exists in the database
  Future<void> update(LocalDto object);

  /// Insert an [item] if it does not exist in database, otherwise update the [item]
  /// returns count of items inserted or updated
  Future<void> insertOrUpdate(LocalDto object);

  /// Insert multiple [items] into database
  /// returns count of items inserted
  Future<void> insertMany(List<LocalDto> list);

  /// Insert or Update multiple [items] in the database
  /// returns true if all operations are completed successfully.
  Future<void> insertOrUpdateMany(List<LocalDto> list);

  /// Returns the items matching the [uniqueIds]
  /// returns a list of items of the type [T]
  Future<List<T>> getEntitiesById(List<String> uniqueIds);

  /// Returns the items matching the provided [filter]
  /// To get all the items set filter to null
  /// returns a list of items of the type [T]
  Future<List<T>> find({Filter? filter});

  /// Remove an item from the database matching the given [filter].
  /// returns count of the [itemsWithQuantity] removed
  Future<void> delete(Filter filter);

  /// Remove all the entities matching the [uniqueId] from the db
  /// returns true if all operations are completed successfully.
  Future<void> deleteById(String uniqueId);

  /// Remove all the entities matching the [uniqueIds] from the db
  /// returns true if all operations are completed successfully.
  Future<void> deleteAll(List<String> uniqueIds);

  /// Clears the database of all the entries
  /// returns count of the [itemsWithQuantity] removed
  Future<void> clear();

  /// Return the count of records in the database
  Future<int> count();

  /// Listen to the changes in the db using the provided query given in [filter]
  /// returns a [Stream] of [T] as [Stream<T?>] that can be null.
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<T?> observeChange({Filter? filter});

  /// Listen to the changes in the db using the provided query given in [filter]
  /// returns a [Stream] of [List] of [T] as [Stream<List<T>>].
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<List<T>> observeChanges({Filter? filter});
}
