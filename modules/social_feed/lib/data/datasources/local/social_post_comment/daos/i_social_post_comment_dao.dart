import 'package:core/core_pure_dart.dart';
import 'package:social_feed/social_feed.dart';

abstract class ISocialPostCommentDao {
  Future<List<SocialPostComment>> get allComments;

  Future<List<SocialPostComment>> getCommentsForPost(int postId);

  Future<void> insertOrUpdateComment(SocialPostComment comment);

  Future<void> insertOrUpdateComments(List<SocialPostComment> comments);

  Future<void> insertOrUpdateCommentResource(SResource<SocialPostComment> post);

  Future<void> insertOrUpdateCommentResources(
      List<SResource<SocialPostComment>> posts);

  Future<void> removeComment(int commentId);

  Future<void> removeComments(List<int> commentIds);

  Future<void> clearCommentsForPost(int postId);

  Future<void> clearAll();

  Stream<List<SocialPostComment>> get observeAllComments;

  Stream<List<SocialPostComment>> observeCommentsForPost(int postId);

  Stream<List<SResource<SocialPostComment>>> get observeAllCommentResources;

  Stream<List<SResource<SocialPostComment>>> observeCommentResourcesForPost(
      int postId);
}
