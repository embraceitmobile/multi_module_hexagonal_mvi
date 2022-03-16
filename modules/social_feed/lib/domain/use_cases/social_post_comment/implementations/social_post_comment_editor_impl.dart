import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';
import 'package:social_feed/domain/interfaces/social_post_comment_repository.dart';
import 'package:social_feed/domain/use_cases/social_post_comment/social_post_comment_use_cases.dart';

@Injectable(as: SocialPostCommentEditor)
class SocialPostCommentEditorImpl implements SocialPostCommentEditor {
  final SocialPostCommentRepository _repository;

  const SocialPostCommentEditorImpl(this._repository);

  @override
  Future<void> updateComment(SocialPostComment post) async {
    try {
      await _repository.updateComment(post);
    } catch (_) {
      rethrow;
    }
  }
}
