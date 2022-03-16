import 'package:social_feed/data/social_post_comment/datasources/local/dtos/social_post_comment_dto.dart';

abstract class ISocialPostCommentLocalDatasource {
  Future<List<SocialPostCommentDto>> get allComments;

  Future<List<SocialPostCommentDto>> getCommentsForPost(int postId);

  Future<void> updateComment(SocialPostCommentDto post);

  Future<void> removeComment(int commentId);

  Future<void> removeComments(List<int> commentIds);

  Future<void> clearCommentsForPost(int postId);

  Stream<List<SocialPostCommentDto>> get observeAllComments;

  Stream<List<SocialPostCommentDto>> observeCommentsForPost(int postId);
}
