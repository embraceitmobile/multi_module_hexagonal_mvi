import 'package:social_feed/domain/entities/social_post_comment.dart';

class SocialPost {
  final int id;
  final int userId;
  final String title;
  final String body;
  final List<SocialPostComment> comments;

  const SocialPost({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
    this.comments = const [],
  });

  @override
  String toString() {
    return 'SocialPost{id: $id, commentsCount: ${comments.length}';
  }
}
