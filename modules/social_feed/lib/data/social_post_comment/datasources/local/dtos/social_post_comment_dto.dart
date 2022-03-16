import 'package:drift/drift.dart';

@DataClassName("social_post_comment")
class SocialPostCommentDto extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get postId => integer()();

  TextColumn get name => text()();

  TextColumn get email => text()();

  TextColumn get body => text()();
}
