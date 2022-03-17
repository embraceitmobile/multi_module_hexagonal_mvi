import 'package:drift/drift.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/data/datasources/local/social_post/daos/i_social_post_dao.dart';
import 'package:social_feed/data/datasources/local/social_post/dtos/social_post_dto.dart';

part 'social_post_dao.g.dart';

@DriftAccessor(tables: [SocialPostDtos])
class SocialPostDao extends DatabaseAccessor<SocialFeedDatabase>
    with _$SocialPostDaoMixin
    implements ISocialPostDao {
  SocialPostDao(SocialFeedDatabase db) : super(db);

  @override
  Future<List<SocialPostDto>> get allPosts async =>
      await select(socialPostDtos).get();

  @override
  Future<SocialPostDto?> getPost(int postId) {
    // TODO: implement getPost
    throw UnimplementedError();
  }

  @override
  Future<List<SocialPostDto>> getPosts(List<int> postIds) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost(SocialPostDto post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }

  @override
  Future<void> removePost(int postId) {
    // TODO: implement removePost
    throw UnimplementedError();
  }

  @override
  Future<void> removePosts(List<int> postIds) {
    // TODO: implement removePosts
    throw UnimplementedError();
  }

  @override
  Future<void> clearPosts() {
    // TODO: implement clearPosts
    throw UnimplementedError();
  }

  @override
  // TODO: implement observeSocialPostDto
  Stream<List<SocialPostDto>> get observePosts =>
      throw UnimplementedError();
}
