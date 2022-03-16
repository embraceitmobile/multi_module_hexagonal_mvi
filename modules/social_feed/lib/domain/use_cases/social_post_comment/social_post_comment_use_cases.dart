import 'package:core/core.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';

abstract class SocialPostCommentReader {
  List<SocialPostComment> get allComments;

  List<SocialPostComment> getCommentsForPost(int postId);
}

abstract class SocialPostCommentWatcher {
  Stream<Resource<List<SuperResource<SocialPostComment>>>>
      get observeAllComments;

  Stream<Resource<List<SuperResource<SocialPostComment>>>>
      observeCommentsForPost(int postId);
}

abstract class SocialPostCommentEditor {
  Future<void> updateComment(SocialPostComment post);
}

abstract class SocialPostCommentRemover {
  Future<void> removeComment(int commentId);

  Future<void> removeComments(List<int> commentIds);

  Future<void> clearCommentsForPost(int postId);
}
