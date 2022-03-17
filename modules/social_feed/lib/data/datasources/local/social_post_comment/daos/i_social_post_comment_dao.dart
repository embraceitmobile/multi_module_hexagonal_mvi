import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';

abstract class ISocialPostCommentDao {
  Future<List<SocialPostCommentDto>> get allComments;

  Future<List<SocialPostCommentDto>> getCommentsForPost(int postId);

  Future<void> insertOrUpdateComment(SocialPostCommentDto comment);

  Future<void> insertOrUpdateComments(List<SocialPostCommentDto> comments);

  Future<void> removeComment(int commentId);

  Future<void> removeComments(List<int> commentIds);

  Future<void> clearCommentsForPost(int postId);

  Stream<List<SocialPostCommentDto>> get observeAllComments;

  Stream<List<SocialPostCommentDto>> observeCommentsForPost(int postId);
}
