import 'package:core/core_pure_dart.dart';
import 'package:social_feed/domain/entities/social_post.dart';

abstract class SocialPostRepository {
  Future<List<SocialPost>> get allPosts;

  Future<SocialPost?> getPost(int postId);

  Future<List<SocialPost>> getPosts(List<int> postIds);

  Future<void> updatePost(SocialPost post);

  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();

  Stream<Resource<List<SResource<SocialPost>>>> get observeSocialPosts;

  Stream<Resource<List<SResource<SocialPost>>>> observePosts(List<int> postIds);
}
