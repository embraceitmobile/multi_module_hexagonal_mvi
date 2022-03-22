import 'package:core/core_pure_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:social_feed/data/datasources/local/social_post_comment/daos/i_social_post_comment_dao.dart';
import 'package:social_feed/data/datasources/remote/social_post_comment/i_social_post_comment_remote_datasource.dart';
import 'package:social_feed/social_feed.dart';

@Singleton(as: SocialPostCommentRepository)
class SocialPostRepositoryImpl implements SocialPostCommentRepository {
  final ISocialPostCommentDao _localDatasource;
  final ISocialPostCommentRemoteDatasource _remoteDatasource;

  late NetworkBoundResource<List<SResource<SocialPostComment>>>
      _socialPostCommentResource;

  SocialPostRepositoryImpl(this._localDatasource, this._remoteDatasource) {
    // _socialPostCommentResource = NetworkBoundResource.withLocalDatasource(
    //     localDatasourceWatcher:
    //         _localDatasource.observeAllComments.toDataStateStream,
    //     shouldFetch: () async => (await _localDatasource.allComments).isEmpty,
    //     onFetchLocalData: () async =>
    //         (await _localDatasource.allComments).toSResource,
    //     onFetchRemoteData: () async =>
    //         (await _remoteDatasource.getComments()).toSResource,
    //     onSaveResultToLocal: (postsResponse) async {
    //       await _localDatasource.insertOrUpdatePostResources(postsResponse);
    //     });
  }

  @override
  // TODO: implement allComments
  Future<List<SocialPostComment>> get allComments => throw UnimplementedError();

  @override
  Future<void> clearCommentsForPost(int postId) {
    // TODO: implement clearCommentsForPost
    throw UnimplementedError();
  }

  @override
  Future<List<SocialPostComment>> getCommentsForPost(int postId) {
    // TODO: implement getCommentsForPost
    throw UnimplementedError();
  }

  @override
  // TODO: implement observeAllComments
  Stream<Resource<List<SResource<SocialPostComment>>>> get observeAllComments => throw UnimplementedError();

  @override
  Stream<Resource<List<SResource<SocialPostComment>>>> observeCommentsForPost(int postId) {
    // TODO: implement observeCommentsForPost
    throw UnimplementedError();
  }

  @override
  Future<void> removeComment(int commentId) {
    // TODO: implement removeComment
    throw UnimplementedError();
  }

  @override
  Future<void> removeComments(List<int> commentIds) {
    // TODO: implement removeComments
    throw UnimplementedError();
  }

  @override
  Future<void> updateComment(SocialPostComment post) {
    // TODO: implement updateComment
    throw UnimplementedError();
  }
}
