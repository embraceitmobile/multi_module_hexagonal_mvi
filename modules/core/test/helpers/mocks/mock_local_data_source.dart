import 'dart:async';

abstract class Dto {
  static const unique_key = 'unique_key';

  /// DbMap should not contain any sub-lists
  Map<String, dynamic> toDtoMap();

  external factory Dto.fromDtoMap(Map<String, dynamic> map);

  String get uniqueKey;
}

abstract class ILocalDataSource<T extends Dto> {
  /// Insert a single [item] into database
  /// returns count of items inserted
  Future<int> insert(T object);

  /// Updates the [item] if it exists in the database
  /// returns the count of the [itemsWithQuantity] updated
  Future<int> update(T object);

  /// Insert multiple [items] into database
  /// returns count of items inserted
  Future<int> insertMany(List<T> list);

  /// Returns all the items in the db
  Future<List<T>> findByAll();

  /// Returns the items matching the provided [id]
  /// To get all the items set filter to null
  /// returns a list of items of the type [T]
  Future<T?> findById(String id);

  /// Remove all the entities matching the [uniqueId] from the db
  /// returns true if all operations are completed successfully.
  Future<int> delete(String uniqueId);

  /// Remove all the entities matching the [uniqueIds] from the db
  /// returns true if all operations are completed successfully.
  Future<int> deleteAll(List<String> uniqueIds);

  /// Clears the database of all the entries
  /// returns count of the [itemsWithQuantity] removed
  Future<int> clear();

  /// Return the count of records in the database
  Future<int> count();

  /// Listen to the changes in the db using
  /// In order to observe the changes emitted in the [Stream], you need to listen
  /// to the stream using [Stream.listen], which returns [StreamSubscription].
  /// All the stream subscriptions need to be cancelled when they are no longer
  /// needs using [StreamSubscription.cancel]
  Stream<List<T>> observeChanges();
}

class MockLocalDatasource<T extends Dto> implements ILocalDataSource<T> {
  final Map<String, T> _dataMap;
  final StreamController<List<T>> _streamController;

  MockLocalDatasource()
      : this._dataMap = {},
        this._streamController = StreamController.broadcast();

  Future<T?> findById(String id) async {
    return _dataMap[id];
  }

  Future<List<T>> findByAll() async {
    return _dataMap.values.toList();
  }

  Future<int> insert(T object) async {
    _dataMap[object.uniqueKey] = object;
    _streamController.sink.add(_dataMap.values.toList());
    return 1;
  }

  Future<int> insertMany(List<T> list) async {
    for (final item in list) {
      _dataMap[item.uniqueKey] = item;
    }

    _streamController.sink.add(_dataMap.values.toList());
    return list.length;
  }

  Future<int> update(T object) async {
    return insert(object);
  }

  Future<int> count() async {
    return _dataMap.length;
  }

  Future<int> delete(String uniqueId) async {
    _dataMap.remove(uniqueId);
    _streamController.sink.add(_dataMap.values.toList());
    return 1;
  }

  Future<int> deleteAll(List<String> uniqueIds) async {
    for (final id in uniqueIds) {
      _dataMap.remove(id);
    }
    _streamController.sink.add(_dataMap.values.toList());
    return uniqueIds.length;
  }

  Future<int> clear() async {
    final count = _dataMap.length;
    _dataMap.clear();
    _streamController.sink.add(_dataMap.values.toList());
    return count;
  }

  Stream<List<T>> observeChanges() {
    return _streamController.stream;
  }

  dispose() {
    _dataMap.clear();
    _streamController.close();
  }
}
