import 'package:core/core_pure_dart.dart';
import 'package:social_feed/social_feed.dart';

abstract class ISocialPostCommentDao {
  Future<List<SocialPostComment>> get allComments;

  Future<List<SocialPostComment>> getCommentsForPost(int postId);

  Future<void> insertOrUpdateComment(SocialPostComment comment);

  Future<void> insertOrUpdateComments(List<SocialPostComment> comments);

  Future<void> removeComment(int commentId);

  Future<void> removeComments(List<int> commentIds);

  Future<void> clearCommentsForPost(int postId);

  Future<void> clearAll();

  Stream<List<SocialPostComment>> get observeAllComments;

  Stream<List<SocialPostComment>> observeCommentsForPost(int postId);
}
