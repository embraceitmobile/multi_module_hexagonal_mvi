import 'package:core/core_pure_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:social_feed/data/datasources/remote/social_post/dtos/social_post_remote_dto.dart';
import 'package:social_feed/domain/entities/social_post.dart';
import 'package:collection/collection.dart';
import 'i_social_post_remote_datasource.dart';

@Singleton(as: ISocialPostRemoteDatasource)
class SocialPostRemoteDatasource implements ISocialPostRemoteDatasource {
  static const String TAG = "RemoteUserDatasource";

  final IRemoteApiClient<dynamic> _apiClient;

  // injecting api client instance
  const SocialPostRemoteDatasource(this._apiClient);

  @override
  Future<List<SocialPost>> getPosts() async {
    try {
      final response = await _apiClient.get(getPostsEndpoint);
      return SocialPostResponse.listFromJson(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  @override
  Future<SocialPost?> getPostById(int id) async {
    try {
      final response = await _apiClient.get(
        getPostsEndpoint,
        queryParameters: {"id": id},
      );
      return SocialPostResponse.listFromJson(response).firstOrNull;
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }
}
