import 'package:core/core_pure_dart.dart';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';

extension SocialPostCommentExtension on SocialPostComment {
  SocialPostCommentDto toSocialPostCommentDto({int? loading, String? error}) =>
      SocialPostCommentDto(
        id: id,
        postId: postId,
        name: name,
        email: email,
        body: body,
        loading: loading,
        error: error,
      );
}

extension SocialPostCommentIterableExtension on Iterable<SocialPostComment>? {
  List<SocialPostCommentDto> get toSocialPostCommentDtos =>
      List<SocialPostCommentDto>.from(
          (this ?? []).map((comment) => comment.toSocialPostCommentDto()));
}

extension SocialPostCommentDtoExtension on SocialPostCommentDto {
  SocialPostComment get toSocialPostComment => SocialPostComment(
      postId: postId, id: id, name: name, email: email, body: body);
}

extension SocialPostCommentDtoIterableExtension
    on Iterable<SocialPostCommentDto>? {
  List<SocialPostComment> get toSocialPostComments =>
      List<SocialPostComment>.from(
          (this ?? []).map((comment) => comment.toSocialPostComment));

  List<SResource<SocialPostComment>> get toSocialPostCommentResources {
    if (this == null) return [];
    return this!
        .map<SResource<SocialPostComment>>((comment) {
          if (comment.error != null) {
            return SResource.error(Exception(comment.error),
                data: comment.toSocialPostComment);
          } else if (comment.loading != null) {
            return SResource.loading(
                progress: comment.loading!, data: comment.toSocialPostComment);
          } else {
            return SResource.success(comment.toSocialPostComment);
          }
        })
        .filterNotNull
        .toList();
  }
}

extension SocialPostCommentResourceExtension on SResource<SocialPostComment> {
  SocialPostCommentDto? get toSocialPostCommentDto => map(
      success: (resource) => resource.data.toSocialPostCommentDto(),
      loading: (resource) => (resource.data as SocialPostComment?)
          ?.toSocialPostCommentDto(loading: resource.progress),
      error: (resource) => (resource.data as SocialPostComment?)
          ?.toSocialPostCommentDto(error: resource.error.toString()),
      nothing: (_) => null);
}

extension SocialPostCommentResourceIterableExtension
    on Iterable<SResource<SocialPostComment>>? {
  List<SocialPostCommentDto> get toSocialPostCommentDtos =>
      List<SocialPostCommentDto>.from((this ?? [])
          .map((comment) => comment.toSocialPostCommentDto)
          .filterNotNull);
}
