import 'dtos/social_post_dto.dart';

abstract class ISocialPostLocalDatasource {
  Future<List<SocialPostDto>> get allPosts;

  Future<SocialPostDto?> getPost(int postId);

  Future<List<SocialPostDto>> getPosts(List<int> postIds);

  Future<void> updatePost(SocialPostDto post);

  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();

  Stream<List<SocialPostDto>> get observeSocialPosts;
}
