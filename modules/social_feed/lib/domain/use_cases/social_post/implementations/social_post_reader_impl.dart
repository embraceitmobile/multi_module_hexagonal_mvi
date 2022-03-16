import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/entities/social_post.dart';
import 'package:social_feed/domain/interfaces/social_post_repository.dart';
import 'package:social_feed/domain/use_cases/social_post/social_post_use_cases.dart';

@Injectable(as: SocialPostReader)
class SocialPostReaderImpl implements SocialPostReader {
  final SocialPostRepository _repository;

  const SocialPostReaderImpl(this._repository);

  @override
  Future<List<SocialPost>> get allPosts async {
    try {
      return await _repository.allPosts;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<SocialPost?> getPost(int postId) async {
    try {
      return await _repository.getPost(postId);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<SocialPost>> getPosts(List<int> postIds) async {
    try {
      return await _repository.getPosts(postIds);
    } catch (_) {
      rethrow;
    }
  }
}
