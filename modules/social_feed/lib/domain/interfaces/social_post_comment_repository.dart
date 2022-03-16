import 'package:core/core.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';

abstract class SocialPostCommentRepository {
  List<SocialPostComment> get allComments;

  List<SocialPostComment> getCommentsForPost(int postId);

  Future<void> updateComment(SocialPostComment post);

  Future<void> removeComment(int commentId);

  Future<void> removeComments(List<int> commentIds);

  Future<void> clearCommentsForPost(int postId);

  Stream<Resource<List<SuperResource<SocialPostComment>>>>
      get observeAllComments;

  Stream<Resource<List<SuperResource<SocialPostComment>>>>
      observeCommentsForPost(int postId);
}
