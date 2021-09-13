import 'package:sembast/sembast.dart';

abstract class Entity {
  static const unique_key = 'unique_key';

  /// DbMap should not contain any sub-lists
  Map<String, dynamic> toEntityMap();

  external factory Entity.fromEntityMap(Map<String, dynamic> map);

  String get uniqueKey;
}

class DbFilters {
  static Filter byUniqueId(String uniqueId) =>
      Filter.equals(Entity.unique_key, uniqueId);

  static Filter byUniqueIds(List<String> uniqueIds) =>
      Filter.inList(Entity.unique_key, uniqueIds);
}

abstract class ISyncable {
  static const FIELD_IS_SYNCED = 'isSynced';
  static const FIELD_IS_SYNCING = 'syncing';

  late bool isSyncing;
  late bool isSynced;
}
