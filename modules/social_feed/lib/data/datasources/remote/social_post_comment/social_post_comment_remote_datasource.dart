import 'package:core/core_pure_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:social_feed/data/datasources/remote/social_post_comment/dtos/social_post_comment_remote_dto.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';
import 'package:collection/collection.dart';
import 'i_social_post_comment_remote_datasource.dart';

@Singleton(as: ISocialPostCommentRemoteDatasource)
class SocialPostCommentRemoteDatasource
    implements ISocialPostCommentRemoteDatasource {
  static const String TAG = "RemoteUserDatasource";

  final IRemoteApiClient<dynamic> _apiClient;

  // injecting api client instance
  const SocialPostCommentRemoteDatasource(this._apiClient);

  @override
  Future<List<SocialPostComment>> getComments() async {
    try {
      final response = await _apiClient.get(getCommentsEndpoint);
      return SocialPostCommentResponse.listFromJson(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  @override
  Future<SocialPostComment?> getCommentById(int commentId) async {
    try {
      final response = await _apiClient.get(
        getCommentsEndpoint,
        queryParameters: {"id": commentId},
      );
      return SocialPostCommentResponse.listFromJson(response).firstOrNull;
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  @override
  Future<List<SocialPostComment>> getCommentsByPostId(int postId) async {
    try {
      final response = await _apiClient.get(
        getCommentsEndpoint,
        queryParameters: {"postId": postId},
      );
      return SocialPostCommentResponse.listFromJson(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }
}
