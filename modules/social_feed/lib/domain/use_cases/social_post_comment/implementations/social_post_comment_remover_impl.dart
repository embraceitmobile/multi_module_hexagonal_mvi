import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/interfaces/social_post_comment_repository.dart';
import 'package:social_feed/domain/use_cases/social_post_comment/social_post_comment_use_cases.dart';

@Injectable(as: SocialPostCommentRemover)
class SocialPostCommentRemoverImpl implements SocialPostCommentRemover {
  final SocialPostCommentRepository _repository;

  const SocialPostCommentRemoverImpl(this._repository);

  @override
  Future<void> clearCommentsForPost(int postId) async {
    try {
      await _repository.clearCommentsForPost(postId);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removeComment(int commentId) async {
    try {
      await _repository.removeComment(commentId);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> removeComments(List<int> commentIds) async {
    try {
      await _repository.removeComments(commentIds);
    } catch (_) {
      rethrow;
    }
  }
}
