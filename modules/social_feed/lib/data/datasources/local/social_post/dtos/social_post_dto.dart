import 'package:drift/drift.dart';

class SocialPostDtos extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();

  TextColumn get error => text().nullable()();

  IntColumn get loading => integer().nullable()();
}
