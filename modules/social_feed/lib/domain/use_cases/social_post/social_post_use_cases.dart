import 'package:core/core.dart';
import 'package:social_feed/domain/entities/social_post.dart';

abstract class SocialPostReader {
  List<SocialPost> get allPosts;

  SocialPost? getPost(int postId);

  List<SocialPost> getPosts(List<int> postIds);
}

abstract class SocialPostWatcher {
  Stream<Resource<List<SuperResource<SocialPost>>>> get observeSocialPosts;
}

abstract class SocialPostEditor {
  Future<void> updatePost(SocialPost post);
}

abstract class SocialPostRemover {
  Future<void> removePost(int postId);

  Future<void> removePosts(List<int> postIds);

  Future<void> clearPosts();
}
