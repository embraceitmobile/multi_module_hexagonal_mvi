import 'package:core/core.dart';

class InvalidDataException implements Exception, GenericDatabaseException {
  final String message;

  InvalidDataException(this.message);

  @override
  String toString() => message;
}
