import 'package:social_feed/domain/entities/social_post_comment.dart';

class SocialPost {
  final String userId;
  final int id;
  final String title;
  final String body;
  final List<SocialPostComment> comments;

  const SocialPost({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    this.comments = const [],
  });
}
