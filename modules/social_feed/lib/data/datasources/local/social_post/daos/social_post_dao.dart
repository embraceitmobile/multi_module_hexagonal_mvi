import 'package:core/core_pure_dart.dart';
import 'package:drift/drift.dart';
import 'package:social_feed/data/datasources/local/converters/social_post_converters.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/data/datasources/local/social_post/daos/i_social_post_dao.dart';
import 'package:social_feed/data/datasources/local/social_post/dtos/social_post_dto.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/i_social_post_comment_dao.dart';
import 'package:collection/collection.dart';
import 'package:social_feed/social_feed.dart';
import 'package:stream_transform/stream_transform.dart';

part 'social_post_dao.g.dart';

@DriftAccessor(tables: [SocialPostDtos])
class SocialPostDao extends DatabaseAccessor<SocialFeedDatabase>
    with _$SocialPostDaoMixin
    implements ISocialPostDao {
  SocialPostDao(SocialFeedDatabase db) : super(db);

  ISocialPostCommentDao get _socialPostCommentDao =>
      attachedDatabase.socialPostCommentDao;

  @override
  Future<List<SocialPost>> get allPosts async {
    try {
      final allCommentsMap = (await _socialPostCommentDao.allComments)
          .groupListsBy((comment) => comment.postId);

      return (await select(socialPostDtos).get()).toSocialPosts(allCommentsMap);
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<SocialPost?> getPost(int postId) async {
    try {
      final post = (await _queryPostById(postId).get()).firstOrNull;
      if (post == null) return null;

      final postCommentDtoList =
          await _socialPostCommentDao.getCommentsForPost(post.id);
      return post.toSocialPost(postCommentDtoList);
    } catch (e) {
      throw EntityNotFoundException(
          entityId: postId.toString(), storeName: "SocialPostDtos");
    }
  }

  @override
  Future<List<SocialPost>> getPosts(List<int> postIds) async {
    try {
      return [
        for (final post in await _queryPostByIds(postIds).get())
          post.toSocialPost(
              (await _socialPostCommentDao.getCommentsForPost(post.id)))
      ];
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<void> insertOrUpdatePost(SocialPost post) async {
    try {
      await transaction(() async {
        await into(socialPostDtos).insertOnConflictUpdate(post.toSocialPostDto);
        if (post.comments.isNotEmpty) {
          await _socialPostCommentDao.insertOrUpdateComments(post.comments);
        }
      });
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<void> insertOrUpdatePosts(List<SocialPost> posts) async {
    try {
      await transaction(() async {
        for (final post in posts) {
          await into(socialPostDtos)
              .insertOnConflictUpdate(post.toSocialPostDto);
          if (post.comments.isNotEmpty) {
            await _socialPostCommentDao.insertOrUpdateComments(post.comments);
          }
        }
      });
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<void> removePost(int postId) async {
    try {
      final query = delete(socialPostDtos)
        ..where((post) => post.id.equals(postId));
      await query.go();
    } catch (e) {
      throw EntityNotFoundException(
        entityId: postId.toString(),
        storeName: "SocialPostDaos",
      );
    }
  }

  @override
  Future<void> removePosts(List<int> postIds) async {
    try {
      final query = delete(socialPostDtos)
        ..where((post) => post.id.isIn(postIds));
      await query.go();
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Future<void> clearPosts() async {
    try {
      await delete(socialPostDtos).go();
    } catch (e) {
      throw GenericDatabaseException(e.toString());
    }
  }

  @override
  Stream<List<SocialPost>> get observeAllPosts {
    return select(socialPostDtos).watch().combineLatest(
        _socialPostCommentDao.observeAllComments, (posts, comments) async {
      final allCommentsMap = (comments as List<SocialPostComment>)
          .groupListsBy((comment) => comment.postId);
      return posts.toSocialPosts(allCommentsMap);
    });
  }

  @override
  Stream<List<SocialPost>> observePosts(List<int> postIds) {
    return _queryPostByIds(postIds)
        .watch()
        .combineLatest(_socialPostCommentDao.observeCommentsForPosts(postIds),
            (posts, comments) async {
      final allCommentsMap = (comments as List<SocialPostComment>)
          .groupListsBy((comment) => comment.postId);
      return posts.toSocialPosts(allCommentsMap);
    });
  }

  MultiSelectable<SocialPostDto> _queryPostById(int postId) =>
      select(socialPostDtos)..where((post) => post.id.equals(postId));

  MultiSelectable<SocialPostDto> _queryPostByIds(List<int> postIds) =>
      select(socialPostDtos)..where((post) => post.id.isIn(postIds));
}
