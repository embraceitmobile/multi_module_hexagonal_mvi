import 'package:core/models/exceptions/database_exception.dart';

class InvalidDataException implements Exception, GenericDatabaseException {
  final String message;

  InvalidDataException(this.message);

  @override
  String toString() => message;
}
