class NullException implements Exception {
  final String message;

  NullException(this.message);

  @override
  String toString() => message;
}
