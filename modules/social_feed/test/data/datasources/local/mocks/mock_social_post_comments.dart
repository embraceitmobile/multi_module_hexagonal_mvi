import 'dart:convert';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/social_feed.dart';
import 'comment_jsons.dart';

final SocialPostComment singleComment1 =
    SocialPostCommentDto.fromJson(jsonDecode(singleCommentJson1))
        .toSocialPostComment;

final SocialPostComment singleComment2 = SocialPostCommentDto.fromJson(
  jsonDecode(singleCommentJson2),
).toSocialPostComment;

final SocialPostComment singleComment3 = SocialPostCommentDto.fromJson(
  jsonDecode(singleCommentJson3),
).toSocialPostComment;

final List<SocialPostComment> multipleComments =
    List<SocialPostCommentDto>.from(jsonDecode(multipleCommentsJson)
            .map((item) => SocialPostCommentDto.fromJson(item)))
        .toSocialPostComments;
