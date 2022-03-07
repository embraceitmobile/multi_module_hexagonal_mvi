import 'package:sembast/sembast.dart';

import 'dto.dart';

class DbFilters {
  static Filter byUniqueId(String uniqueId) =>
      Filter.equals(LocalDto.unique_key, uniqueId);

  static Filter byUniqueIds(List<String> uniqueIds) =>
      Filter.inList(LocalDto.unique_key, uniqueIds);
}

abstract class ISyncable {
  static const FIELD_IS_SYNCED = 'isSynced';
  static const FIELD_IS_SYNCING = 'syncing';

  late bool isSyncing;
  late bool isSynced;
}
