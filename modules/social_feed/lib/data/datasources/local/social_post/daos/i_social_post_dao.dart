import 'package:core/core_pure_dart.dart';
import 'package:social_feed/domain/entities/social_post.dart';

abstract class ISocialPostDao {
  Future<List<SocialPost>> get allPosts;

  Future<SocialPost?> getPost(int postId);

  Future<List<SocialPost>> getPosts(List<int> postIds);

  Future<void> insertOrUpdatePost(SocialPost post);

  Future<void> insertOrUpdatePosts(List<SocialPost> posts);

  Future<void> insertOrUpdatePostResource(SResource<SocialPost> post);

  Future<void> insertOrUpdatePostResources(List<SResource<SocialPost>> posts);

  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();

  Stream<List<SResource<SocialPost>>> get observeAllPosts;
}
