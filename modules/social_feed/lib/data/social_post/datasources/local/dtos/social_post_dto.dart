import 'package:drift/drift.dart';

@DataClassName("social_post")
class SocialPostDto extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get userId => integer()();

  TextColumn get title => text()();

  TextColumn get body => text()();
}
