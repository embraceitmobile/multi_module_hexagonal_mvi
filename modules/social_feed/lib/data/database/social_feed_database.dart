import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:social_feed/data/social_post/datasources/local/dtos/social_post_dto.dart';
import 'package:social_feed/data/social_post_comment/datasources/local/dtos/social_post_comment_dto.dart';

part 'social_feed_database.g.dart';

@DriftDatabase(tables: [SocialPostDto, SocialPostCommentDto])
class SocialFeedDatabase extends _$SocialFeedDatabase {
  SocialFeedDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    // the LazyDatabase util lets us find the right location for the file async.
    return LazyDatabase(() async {
      // put the database file, called db.sqlite here, into the documents folder
      // for your app.
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'db.sqlite'));
      return NativeDatabase(file);
    });
  }
}
