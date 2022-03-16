import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';
import 'package:social_feed/domain/interfaces/social_post_comment_repository.dart';
import 'package:social_feed/domain/use_cases/social_post_comment/social_post_comment_use_cases.dart';

@Injectable(as: SocialPostCommentReader)
class SocialPostCommentReaderImpl implements SocialPostCommentReader {
  final SocialPostCommentRepository _repository;

  const SocialPostCommentReaderImpl(this._repository);

  @override
  Future<List<SocialPostComment>> get allComments async {
    try {
      return await _repository.allComments;
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<SocialPostComment>> getCommentsForPost(int postId) async {
    try {
      return await _repository.getCommentsForPost(postId);
    } catch (_) {
      rethrow;
    }
  }
}
