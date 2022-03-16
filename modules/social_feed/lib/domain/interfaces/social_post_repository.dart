import 'package:core/core.dart';
import 'package:social_feed/domain/entities/social_post.dart';

abstract class SocialPostRepository {
  List<SocialPost> get allPosts;

  SocialPost? getPost(int postId);

  List<SocialPost> getPosts(List<int> postIds);

  Future<void> updatePost(SocialPost post);

  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();

  Stream<Resource<List<SuperResource<SocialPost>>>> get observeSocialPosts;
}