import 'package:social_feed/domain/entities/social_post.dart';

abstract class ISocialPostDao {
  Future<List<SocialPost>> get allPosts;

  Future<SocialPost?> getPost(int postId);

  Future<List<SocialPost>> getPosts(List<int> postIds);

  Future<void> insertOrUpdatePost(SocialPost post);

  Future<void> insertOrUpdatePosts(List<SocialPost> posts);

  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();

  Stream<List<SocialPost>> get observeAllPosts;

  Stream<List<SocialPost>> observePosts(List<int> postIds);
}
