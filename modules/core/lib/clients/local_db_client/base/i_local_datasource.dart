import 'package:core/clients/local_db_client/base/dto.dart';
import 'package:sembast/sembast.dart';

abstract class ILocalDataSource<T> {
  /// Insert a single [item] into database
  /// returns count of items inserted
  Future<int> insert(Dto object);

  /// Updates the [item] if it exists in the database
  /// returns the count of the [itemsWithQuantity] updated
  Future<int> update(Dto object);

  /// Insert an [item] if it does not exist in database, otherwise update the [item]
  /// returns count of items inserted or updated
  Future<int> insertOrUpdate(Dto object);

  /// Insert multiple [items] into database
  /// returns count of items inserted
  Future<List<int>> insertMany(List<Dto> list);

  /// Insert or Update multiple [items] in the database
  /// returns true if all operations are completed successfully.
  Future<bool> insertOrUpdateMany(List<Dto> list);

  Future<int> insertWithKey(Dto object);

  Future<int> updateWithKey(Dto object);

  /// Returns the items matching the [uniqueIds]
  /// returns a list of items of the type [T]
  Future<List<T>> getEntitiesById(List<String> uniqueIds);

  /// Returns the items matching the provided [filter]
  /// To get all the items set filter to null
  /// returns a list of items of the type [T]
  Future<List<T>> find({Filter? filter});

  /// Returns the items matching the provided [filter]
  /// To get all the items set filter to null
  /// returns a list of items of the type [T]
  Future<T?> findById({Filter? filter});

  /// Remove an item from the database matching the given [filter].
  /// returns count of the [itemsWithQuantity] removed
  Future<int> delete(Filter filter);

  /// Remove all the entities matching the [uniqueId] from the db
  /// returns true if all operations are completed successfully.
  Future<int> deleteById(String uniqueId);

  /// Remove all the entities matching the [uniqueIds] from the db
  /// returns true if all operations are completed successfully.
  Future<int> deleteAll(List<String> uniqueIds);

  /// Clears the database of all the entries
  /// returns count of the [itemsWithQuantity] removed
  Future<int> clear();

  /// Return the count of records in the database
  Future<int> count();

  /// Listen to the changes in the db using the provided query given in [filter]
  /// returns a [Stream] of [List] of [T] as [Stream<List<T>>].
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<List<T>> observeChanges({Filter? filter});
}
