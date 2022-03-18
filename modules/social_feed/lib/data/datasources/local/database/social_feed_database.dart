import 'package:drift/drift.dart';
import 'package:social_feed/data/datasources/local/social_post/daos/social_post_dao.dart';
import 'package:social_feed/data/datasources/local/social_post/dtos/social_post_dto.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/social_post_comment_dao.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/dtos/social_post_comment_dto.dart';

export 'package:social_feed/data/datasources/local/converters/social_post_comment_converters.dart';
export 'package:social_feed/data/datasources/local/converters/social_post_converters.dart';

part 'social_feed_database.g.dart';

@DriftDatabase(
    tables: [SocialPostDtos, SocialPostCommentDtos],
    daos: [SocialPostDao, SocialPostCommentDao])
class SocialFeedDatabase extends _$SocialFeedDatabase {
  SocialFeedDatabase(QueryExecutor queryExecutor) : super(queryExecutor);

  @override
  int get schemaVersion => 1;
}


