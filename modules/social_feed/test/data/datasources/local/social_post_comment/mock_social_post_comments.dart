import 'dart:convert';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'comment_jsons.dart';

final SocialPostCommentDto singleComment1 = SocialPostCommentDto.fromJson(
  jsonDecode(singleCommentJson1),
);

final SocialPostCommentDto singleComment2 = SocialPostCommentDto.fromJson(
  jsonDecode(singleCommentJson2),
);

final SocialPostCommentDto singleComment3 = SocialPostCommentDto.fromJson(
  jsonDecode(singleCommentJson3),
);

final List<SocialPostCommentDto> multipleComments =
    List<SocialPostCommentDto>.from(jsonDecode(multipleCommentsJson)
        .map((item) => SocialPostCommentDto.fromJson(item)));
