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
    try {
      final posts = await _socialPostResource.fetch();

      if (posts == null) return [];
      return posts.map((post) => post.successOrNull).filterNotNull.toList();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<SocialPost?> getPost(int postId) async {
    try {
      final cachedResponse = await _localDatasource.getPost(postId);
      if (cachedResponse != null) return cachedResponse;

      await _localDatasource.insertOrUpdatePostResource(
          SResource.loading(progress: -1, data: SocialPost.empty(postId)));

      final response = await _remoteDatasource.getPostById(postId);
      if (response != null) await _localDatasource.insertOrUpdatePost(response);
      return response;
    } on Exception catch (e) {
      await _localDatasource.insertOrUpdatePostResource(
        SResource.error(e, data: SocialPost.empty(postId)),
      );
      rethrow;
    }
  }

  @override
  Future<List<SocialPost>> getPosts(List<int> postIds) async {
    try {
      final cachedResponse = await _localDatasource.getPosts(postIds);
      if (cachedResponse.length == postIds.length) return cachedResponse;

      await _localDatasource.insertOrUpdatePostResources(postIds
          .map((postId) =>
              SResource.loading(progress: -1, data: SocialPost.empty(postId)))
          .toList());

      final response = (await Future.wait(
              postIds.map((id) => _remoteDatasource.getPostById(id))))
          .filterNotNull;
      if (response.isNotEmpty) {
        await _localDatasource.insertOrUpdatePosts(response);
      }
      return response;
    } on Exception catch (e) {
      await _localDatasource.insertOrUpdatePostResources(postIds
          .map((postId) => SResource.error(e, data: SocialPost.empty(postId)))
          .toList());
      rethrow;
    }
  }

  @override
  Future<void> updatePost(SocialPost post) async {
    try {
      await _localDatasource.insertOrUpdatePost(post);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removePost(int postId) async {
    try {
      await _localDatasource.removePost(postId);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removePosts(List<int> postIds) async {
    try {
      await _localDatasource.removePosts(postIds);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> clearPosts() async {
    try {
      await _localDatasource.clearPosts();
    } catch (_) {
      rethrow;
    }
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
