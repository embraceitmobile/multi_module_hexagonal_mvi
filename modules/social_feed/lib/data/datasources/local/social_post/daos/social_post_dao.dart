import 'package:drift/drift.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/data/datasources/local/social_post/daos/i_social_post_dao.dart';
import 'package:social_feed/data/datasources/local/social_post/dtos/social_post_dto.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/i_social_post_comment_dao.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/social_post_comment_dao.dart';
import 'package:social_feed/domain/entities/social_post.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';
import 'package:collection/collection.dart';

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
    final allCommentsMap = (await _socialPostCommentDao.allComments)
        .groupListsBy((comment) => comment.id);

    return (await select(socialPostDtos).get()).toSocialPosts(allCommentsMap);
  }

  @override
  Future<SocialPost?> getPost(int postId) async {
    final post = (await _queryPostById(postId).get()).firstOrNull;
    if (post == null) return null;

    final postCommentDtoList =
        await _socialPostCommentDao.getCommentsForPost(post.id);
    return post.toSocialPost(postCommentDtoList.toSocialPostComments);
  }

  @override
  Future<List<SocialPost>> getPosts(List<int> postIds) async {
    final posts = await (select(socialPostDtos)
          ..where((post) => post.id.isIn(postIds)))
        .get();

    return [
      for (final post in posts)
        post.toSocialPost(
            (await _socialPostCommentDao.getCommentsForPost(post.id))
                .toSocialPostComments)
    ];
  }

  @override
  Future<void> insertOrUpdatePost(SocialPost post) {
    // TODO: implement insertOrUpdatePost
    throw UnimplementedError();
  }

  @override
  Future<void> insertOrUpdatePosts(List<SocialPost> post) {
    // TODO: implement insertOrUpdatePosts
    throw UnimplementedError();
  }

  @override
  Future<void> removePost(int postId) {
    // TODO: implement removePost
    throw UnimplementedError();
  }

  @override
  Future<void> removePosts(List<int> postIds) {
    // TODO: implement removePosts
    throw UnimplementedError();
  }

  @override
  Future<void> clearPosts() async {
    // TODO: implement clearPosts
    throw UnimplementedError();
  }

  @override
  // TODO: implement observePosts
  Stream<List<SocialPost>> get observeAllPosts => throw UnimplementedError();

  MultiSelectable<SocialPostDto> _queryPostById(int postId) =>
      select(socialPostDtos)..where((post) => post.id.equals(postId));

  @override
  Stream<List<SocialPost>> observePosts(List<int> postIds) {
    // TODO: implement observePosts
    throw UnimplementedError();
  }
}

extension on SocialPostCommentDto {
  SocialPostComment get toSocialPostComment => SocialPostComment(
      postId: postId, id: id, name: name, email: email, body: body);
}

extension on Iterable<SocialPostCommentDto>? {
  List<SocialPostComment> get toSocialPostComments => this == null
      ? []
      : List<SocialPostComment>.from(
          this!.map((comment) => comment.toSocialPostComment));
}

extension on SocialPostDto {
  SocialPost toSocialPost(List<SocialPostComment> comments) => SocialPost(
        id: id,
        userId: userId,
        title: title,
        body: body,
        comments: comments,
      );
}

extension on Iterable<SocialPostDto> {
  List<SocialPost> toSocialPosts(
          Map<int, List<SocialPostCommentDto>> allCommentsMap) =>
      map((post) => post.toSocialPost(
            allCommentsMap[post.id].toSocialPostComments,
          )).toList();
}
