import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';

abstract class ISocialPostDao {
  Future<List<SocialPostDto>> get allPosts;

  Future<SocialPostDto?> getPost(int postId);

  Future<List<SocialPostDto>> getPosts(List<int> postIds);

  Future<void> updatePost(SocialPostDto post);

  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();

  Stream<List<SocialPostDto>> get observePosts;
}
