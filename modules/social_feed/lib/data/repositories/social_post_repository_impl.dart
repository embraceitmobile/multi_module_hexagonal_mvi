import 'package:core/core_pure_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:social_feed/data/datasources/local/social_post/daos/i_social_post_dao.dart';
import 'package:social_feed/data/datasources/remote/social_post/i_social_post_remote_datasource.dart';
import 'package:social_feed/social_feed.dart';
import 'package:collection/collection.dart';

@Singleton(as: SocialPostRepository)
class SocialPostRepositoryImpl implements SocialPostRepository {
  final ISocialPostDao _localDatasource;
  final ISocialPostRemoteDatasource _remoteDatasource;

  late NetworkBoundResource<List<SResource<SocialPost>>> _socialPostResource;

  SocialPostRepositoryImpl(this._localDatasource, this._remoteDatasource) {
    _socialPostResource = NetworkBoundResource.withLocalDatasource(
        localDatasourceWatcher:
            _localDatasource.observeAllPosts.toDataStateStream,
        shouldFetch: () async => (await _localDatasource.allPosts).isEmpty,
        onFetchLocalData: () async =>
            (await _localDatasource.allPosts).toSResource,
        onFetchRemoteData: () async =>
            (await _remoteDatasource.getPosts()).toSResource,
        onSaveResultToLocal: (postsResponse) async {
          await _localDatasource.insertOrUpdatePostResources(postsResponse);
        });
  }

  @override
  Future<List<SocialPost>> get allPosts async {
    try {} catch (_) {
      rethrow;
    }
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<SocialPost?> getPost(int postId) async {
    try {} catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<SocialPost>> getPosts(List<int> postIds) {
    // TODO: implement getPosts
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost(SocialPost post) {
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
  // TODO: implement observeSocialPosts
  Stream<Resource<List<SResource<SocialPost>>>> get observeSocialPosts =>
      throw UnimplementedError();

  @override
  Stream<Resource<List<SResource<SocialPost>>>> observePosts(
      List<int> postIds) {
    // TODO: implement observePosts
    throw UnimplementedError();
  }
}

extension IterablePostExtension on Iterable<SocialPost> {
  List<SResource<SocialPost>> get toSResource =>
      map((post) => SResource.success(post)).toList();
}

extension StreamIterablePostExtension on Stream<List<SocialPost>> {
  Stream<Resource<List<SResource<SocialPost>>>> get toResource =>
      map((posts) => posts.toSResource).toDataStateStream;
}
