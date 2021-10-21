class InvalidDataException implements Exception {
  final String message;

  InvalidDataException(this.message);

  String toString() => message;
}
