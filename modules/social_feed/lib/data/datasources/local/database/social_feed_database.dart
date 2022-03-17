import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:social_feed/data/datasources/local/social_post/daos/social_post_dao.dart';
import 'package:social_feed/data/datasources/local/social_post/dtos/social_post_dto.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/dtos/social_post_comment_dto.dart';

part 'social_feed_database.g.dart';

@DriftDatabase(
    tables: [SocialPostDtos, SocialPostCommentDtos], daos: [SocialPostDao])
class SocialFeedDatabase extends _$SocialFeedDatabase {
  SocialFeedDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 1;
}

LazyDatabase lazyDatabase() {
// the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
// put the database file, called db.sqlite here, into the documents folder
// for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
