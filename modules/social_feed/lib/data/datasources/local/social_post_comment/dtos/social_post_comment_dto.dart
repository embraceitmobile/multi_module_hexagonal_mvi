import 'package:drift/drift.dart';

class SocialPostCommentDtos extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get postId => integer()();

  TextColumn get name => text()();

  TextColumn get email => text()();

  TextColumn get body => text()();

  IntColumn get loading => integer().nullable()();

  TextColumn get error => text().nullable()();
}
