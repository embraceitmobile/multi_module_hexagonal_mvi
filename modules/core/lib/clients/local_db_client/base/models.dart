import 'package:sembast/sembast.dart';

import 'entity.dart';

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
