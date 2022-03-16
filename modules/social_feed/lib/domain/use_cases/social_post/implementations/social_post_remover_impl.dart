import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/interfaces/social_post_repository.dart';
import 'package:social_feed/domain/use_cases/social_post/social_post_use_cases.dart';

@Injectable(as: SocialPostRemover)
class SocialPostRemoverImpl implements SocialPostRemover {
  final SocialPostRepository _repository;

  const SocialPostRemoverImpl(this._repository);

  @override
  Future<void> clearPosts() async {
    try {
      await _repository.clearPosts();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removePost(int postId) async {
    try {
      await _repository.removePost(postId);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removePosts(List<int> postIds) async {
    try {
      await _repository.removePosts(postIds);
    } catch (_) {
      rethrow;
    }
  }
}
