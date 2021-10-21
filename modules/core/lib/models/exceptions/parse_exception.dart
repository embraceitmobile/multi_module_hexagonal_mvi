class ParseException implements Exception {
  final String message;

  ParseException(this.message);

  String toString() => message;
}
