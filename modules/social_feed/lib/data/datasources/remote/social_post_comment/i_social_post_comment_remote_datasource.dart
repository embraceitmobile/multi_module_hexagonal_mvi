import 'package:social_feed/social_feed.dart';

abstract class ISocialPostCommentRemoteDatasource {
  Future<List<SocialPostComment>> getPostComments();

  Future<List<SocialPostComment>> getPostCommentsById(int commentId);

  Future<List<SocialPostComment>> getPostCommentsByPostId(int postId);
}
