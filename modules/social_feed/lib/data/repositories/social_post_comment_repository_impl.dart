import 'package:core/core_pure_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/i_social_post_comment_dao.dart';
import 'package:social_feed/data/datasources/remote/social_post_comment/i_social_post_comment_remote_datasource.dart';
import 'package:social_feed/social_feed.dart';

@Singleton(as: SocialPostCommentRepository)
class SocialPostRepositoryImpl implements SocialPostCommentRepository {
  final ISocialPostCommentDao _localDatasource;
  final ISocialPostCommentRemoteDatasource _remoteDatasource;

  late NetworkBoundResource<List<SocialPostComment>> _socialPostCommentResource;

  SocialPostRepositoryImpl(this._localDatasource, this._remoteDatasource) {
    _socialPostCommentResource = NetworkBoundResource.withLocalDatasource(
        localDatasourceWatcher:
            _localDatasource.observeAllComments.toDataStateStream,
        shouldFetch: () async => (await _localDatasource.allComments).isEmpty,
        onFetchLocalData: () async => await _localDatasource.allComments,
        onFetchRemoteData: () async => await _remoteDatasource.getComments(),
        onSaveResultToLocal: (postsResponse) async {
          await _localDatasource.insertOrUpdateComments(postsResponse);
        });
  }

  @override
  Future<List<SocialPostComment>> get allComments async {
    try {
      final posts = await _socialPostCommentResource.fetch();
      return posts ?? [];
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<SocialPostComment>> getCommentsForPost(int postId) async {
    try {
      final cachedResponse = await _localDatasource.getCommentsForPost(postId);
      if (cachedResponse.isNotEmpty) return cachedResponse;

      final response = await _remoteDatasource.getCommentsByPostId(postId);
      if (response.isNotEmpty) {
        await _localDatasource.insertOrUpdateComments(response);
      }
      return response;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> updateComment(SocialPostComment comment) async {
    try {
      await _localDatasource.insertOrUpdateComment(comment);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removeComment(int commentId) async {
    try {
      await _localDatasource.removeComment(commentId);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removeComments(List<int> commentIds) async {
    try {
      await _localDatasource.removeComments(commentIds);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> clearCommentsForPost(int postId) async {
    try {
      await _localDatasource.clearCommentsForPost(postId);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Stream<Resource<List<SocialPostComment>>> get observeAllComments =>
      _socialPostCommentResource.resourceWatcher;

  @override
  Stream<Resource<List<SocialPostComment>>> observeCommentsForPost(int postId) {
    return observeAllComments.map(
      (resource) => resource.mapSuccessOnly((success) => Resource.success(
          success.data.where((comment) => comment.postId == postId).toList())),
    );
  }
}

extension StreamIterablePostExtension on Stream<List<SocialPostComment>> {
  Stream<Resource<List<SResource<SocialPostComment>>>> get toResource =>
      map((posts) => posts.toSResource).toDataStateStream;
}
