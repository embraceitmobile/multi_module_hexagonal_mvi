import 'package:core/models/resource/resource.dart';
import 'package:core/models/resource/s_resource.dart';
import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';
import 'package:social_feed/domain/interfaces/social_post_comment_repository.dart';
import 'package:social_feed/domain/use_cases/social_post_comment/social_post_comment_use_cases.dart';

@Injectable(as: SocialPostCommentWatcher)
class SocialPostCommentWatcherImpl implements SocialPostCommentWatcher {
  final SocialPostCommentRepository _repository;

  const SocialPostCommentWatcherImpl(this._repository);

  @override
  Stream<Resource<List<SResource<SocialPostComment>>>> get observeAllComments =>
      _repository.observeAllComments;

  @override
  Stream<Resource<List<SResource<SocialPostComment>>>> observeCommentsForPost(
          int postId) =>
      _repository.observeCommentsForPost(postId);
}
