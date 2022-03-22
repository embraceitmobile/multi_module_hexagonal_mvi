import 'package:social_feed/social_feed.dart';

abstract class ISocialPostRemoteDatasource {
  Future<List<SocialPost>> getPosts();

  Future<SocialPost?> getPostById(int id);
}
