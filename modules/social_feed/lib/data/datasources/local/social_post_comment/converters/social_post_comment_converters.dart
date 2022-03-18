import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/domain/entities/social_post_comment.dart';

extension SocialPostCommentExtension on SocialPostComment {
  SocialPostCommentDto get toSocialPostCommentDto => SocialPostCommentDto(
        id: id,
        postId: postId,
        name: name,
        email: email,
        body: body,
      );
}

extension SocialPostCommentIterableExtension on Iterable<SocialPostComment>? {
  List<SocialPostCommentDto> get toSocialPostCommentDtos =>
      List<SocialPostCommentDto>.from(
          (this ?? []).map((comment) => comment.toSocialPostCommentDto));
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
}

