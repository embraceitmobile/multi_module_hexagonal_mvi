import 'package:core/core_pure_dart.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/domain/entities/social_post.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';

extension SocialPostExtension on SocialPost {
  SocialPostDto toSocialPostDto({String? error, int? loading}) => SocialPostDto(
        id: id,
        userId: userId,
        title: title,
        body: body,
        error: error,
        loading: loading,
      );
}

extension SocialPostIterableExtension on Iterable<SocialPost>? {
  List<SocialPostDto> get toSocialPostDtos => List<SocialPostDto>.from(
      (this ?? []).map((post) => post.toSocialPostDto()));
}

extension SocialPostDtoExtension on SocialPostDto {
  SocialPost toSocialPost([List<SocialPostComment> comments = const []]) =>
      SocialPost(
        id: id,
        userId: userId,
        title: title,
        body: body,
        comments: comments,
      );
}

extension SocialPostDtoIterableExtension on Iterable<SocialPostDto> {
  List<SocialPost> toSocialPosts(
          [Map<int, List<SocialPostComment>> allCommentsMap = const {}]) =>
      map((post) => post.toSocialPost(allCommentsMap[post.id] ?? [])).toList();

  List<SResource<SocialPost>> toSocialPostResources(
          [Map<int, List<SocialPostComment>> allCommentsMap = const {}]) =>
      map((post) {
        if (post.error != null) {
          return SResource.error(Exception(post.error),
              data: post.toSocialPost(allCommentsMap[post.id] ?? []));
        } else if (post.loading != null) {
          return SResource.loading(
              progress: post.loading!,
              data: post.toSocialPost(allCommentsMap[post.id] ?? []));
        } else {
          return SResource.success(
              post.toSocialPost(allCommentsMap[post.id] ?? []));
        }
      }).filterNotNull.toList();
}
