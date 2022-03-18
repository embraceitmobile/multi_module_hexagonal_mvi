import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/social_feed.dart';

extension SocialPostExtension on SocialPost {
  SocialPostDto get toSocialPostDto => SocialPostDto(
        id: id,
        userId: userId,
        title: title,
        body: body,
      );
}

extension SocialPostIterableExtension on Iterable<SocialPost>? {
  List<SocialPostDto> get toSocialPostDtos => List<SocialPostDto>.from(
      (this ?? []).map((post) => post.toSocialPostDto));
}

extension SocialPostDtoExtension on SocialPostDto {
  SocialPost toSocialPost(List<SocialPostComment> comments) => SocialPost(
        id: id,
        userId: userId,
        title: title,
        body: body,
        comments: comments,
      );
}

extension SocialPostDtoIterableExtension on Iterable<SocialPostDto> {
  List<SocialPost> toSocialPosts(
          Map<int, List<SocialPostComment>> allCommentsMap) =>
      map((post) => post.toSocialPost(allCommentsMap[post.id] ?? [])).toList();
}
