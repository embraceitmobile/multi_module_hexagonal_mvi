import 'package:core/models/resource/resource.dart';
import 'package:core/models/resource/s_resource.dart';
import 'package:injectable/injectable.dart';
import 'package:social_feed/domain/entities/social_post.dart';
import 'package:social_feed/domain/interfaces/social_post_repository.dart';
import 'package:social_feed/domain/use_cases/social_post/social_post_use_cases.dart';

@Injectable(as: SocialPostWatcher)
class SocialPostWatcherImpl implements SocialPostWatcher {
  final SocialPostRepository _repository;

  const SocialPostWatcherImpl(this._repository);

  @override
  Stream<Resource<List<SResource<SocialPost>>>> get observeSocialPosts =>
      _repository.observeSocialPosts;
}
