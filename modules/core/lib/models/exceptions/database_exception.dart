class GenericDatabaseException implements Exception {
  final String message;

  const GenericDatabaseException(this.message);

  @override
  String toString() => message;
}
