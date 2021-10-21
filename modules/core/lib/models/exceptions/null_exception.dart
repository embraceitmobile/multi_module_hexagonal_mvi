class NullException implements Exception {
  final String message;

  NullException(this.message);

  String toString() => message;
}
