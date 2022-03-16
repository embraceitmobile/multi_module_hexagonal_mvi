import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/entities/social_post.dart';
import 'package:social_feed/domain/interfaces/social_post_repository.dart';
import 'package:social_feed/domain/use_cases/social_post/social_post_use_cases.dart';

@Injectable(as: SocialPostEditor)
class SocialPostEditorImpl implements SocialPostEditor {
  final SocialPostRepository _repository;

  const SocialPostEditorImpl(this._repository);

  @override
  Future<void> updatePost(SocialPost post) async {
    try {
      await _repository.updatePost(post);
    } catch (_) {
      rethrow;
    }
  }
}
