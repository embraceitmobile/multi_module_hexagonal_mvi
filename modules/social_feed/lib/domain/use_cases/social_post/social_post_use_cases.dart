import 'package:core/core_pure_dart.dart';
import 'package:social_feed/domain/entities/social_post.dart';

abstract class SocialPostReader {
  Future<List<SocialPost>> get allPosts;

  Future<SocialPost?> getPost(int postId);

  Future<List<SocialPost>> getPosts(List<int> postIds);
}

abstract class SocialPostWatcher {
  Stream<Resource<List<SResource<SocialPost>>>> get observeSocialPosts;
}

abstract class SocialPostEditor {
  Future<void> updatePost(SocialPost post);
}

abstract class SocialPostRemover {
  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();
}
