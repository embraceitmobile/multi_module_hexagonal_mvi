import 'package:core/models/exceptions/database_exception.dart';
import 'package:core/models/exceptions/entity_not_found_exception.dart';
import 'package:drift/drift.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/dtos/social_post_comment_dto.dart';
import 'i_social_post_comment_dao.dart';

part 'social_post_comment_dao.g.dart';

@DriftAccessor(tables: [SocialPostCommentDtos])
class SocialPostCommentDao extends DatabaseAccessor<SocialFeedDatabase>
    with _$SocialPostCommentDaoMixin
    implements ISocialPostCommentDao {
  SocialPostCommentDao(SocialFeedDatabase db) : super(db);

  @override
  Future<List<SocialPostCommentDto>> get allComments async {
    try {
      return await select(socialPostCommentDtos).get();
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<List<SocialPostCommentDto>> getCommentsForPost(int postId) async {
    try {
      return await _queryCommentsByPostId(postId).get();
    } catch (e) {
      throw EntityNotFoundException(
        entityId: postId.toString(),
        storeName: "SocialPostCommentDaos",
      );
    }
  }

  @override
  Future<void> insertOrUpdateComment(SocialPostCommentDto comment) async {
    try {
      await into(socialPostCommentDtos).insertOnConflictUpdate(comment);
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<void> insertOrUpdateComments(
      List<SocialPostCommentDto> comments) async {
    try {
      await transaction(() async {
        for (final comment in comments) {
          await into(socialPostCommentDtos).insertOnConflictUpdate(comment);
        }
      });
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<void> removeComment(int commentId) async {
    try {
      final query = delete(socialPostCommentDtos)
        ..where((comment) => comment.id.equals(commentId));
      await query.go();
    } catch (e) {
      throw EntityNotFoundException(
        entityId: commentId.toString(),
        storeName: "SocialPostCommentDaos",
      );
    }
  }

  @override
  Future<void> removeComments(List<int> commentIds) async {
    try {
      final query = delete(socialPostCommentDtos)
        ..where((comment) => comment.id.isIn(commentIds));
      await query.go();
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<void> clearCommentsForPost(int postId) async {
    try {
      final query = delete(socialPostCommentDtos)
        ..where((comment) => comment.postId.equals(postId));
      await query.go();
    } catch (e) {
      throw EntityNotFoundException(
        entityId: postId.toString(),
        storeName: "SocialPostCommentDaos",
      );
    }
  }

  @override
  Future<void> clearAll() async {
    try {
      final query = delete(socialPostCommentDtos);
      await query.go();
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Stream<List<SocialPostCommentDto>> get observeAllComments =>
      select(socialPostCommentDtos).watch();

  @override
  Stream<List<SocialPostCommentDto>> observeCommentsForPosts(
          List<int> postIds) =>
      _queryCommentsByPostIds(postIds).watch();

  @override
  Stream<List<SocialPostCommentDto>> observeCommentsForPost(int postId) =>
      _queryCommentsByPostId(postId).watch();

  MultiSelectable<SocialPostCommentDto> _queryCommentsByPostId(int postId) =>
      select(socialPostCommentDtos)
        ..where((post) => post.postId.equals(postId));

  MultiSelectable<SocialPostCommentDto> _queryCommentsByPostIds(
          List<int> postIds) =>
      select(socialPostCommentDtos)..where((post) => post.postId.isIn(postIds));
}
