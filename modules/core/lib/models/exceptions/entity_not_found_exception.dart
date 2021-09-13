class EntityNotFoundException implements Exception {
  final String entityId;
  final String storeName;
  String get message =>
      "Unable to find the entity with key <$entityId> in store <$storeName>";

  EntityNotFoundException({required this.entityId, required this.storeName});

  @override
  String toString() => message;
}
