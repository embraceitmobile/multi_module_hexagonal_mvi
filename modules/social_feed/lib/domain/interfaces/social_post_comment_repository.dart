import 'package:core/core_pure_dart.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';

abstract class SocialPostCommentRepository {
  Future<List<SocialPostComment>> get allComments;

  Future<List<SocialPostComment>> getCommentsForPost(int postId);

  Future<void> updateComment(SocialPostComment post);

  Future<void> removeComment(int commentId);

  Future<void> removeComments(List<int> commentIds);

  Future<void> clearCommentsForPost(int postId);

  Stream<Resource<List<SResource<SocialPostComment>>>> get observeAllComments;

  Stream<Resource<List<SResource<SocialPostComment>>>> observeCommentsForPost(
      int postId);
}
