import 'package:social_feed/social_feed.dart';

abstract class ISocialPostCommentRemoteDatasource {
  Future<List<SocialPostComment>> getComments();

  Future<SocialPostComment?> getCommentById(int commentId);

  Future<List<SocialPostComment>> getCommentsByPostId(int postId);
}
