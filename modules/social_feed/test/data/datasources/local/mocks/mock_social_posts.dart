import 'dart:convert';
import 'package:social_feed/data/datasources/local/database/social_feed_database.dart';
import 'package:social_feed/social_feed.dart';

import 'mock_social_post_comments.dart';
import 'post_jsons.dart';

final SocialPost singlePost1 =
    SocialPostDto.fromJson(jsonDecode(singlePostJson1)).toSocialPost();

final SocialPost singlePost2 =
    SocialPostDto.fromJson(jsonDecode(singlePostJson2)).toSocialPost();

final SocialPost singlePost3 =
    SocialPostDto.fromJson(jsonDecode(singlePostJson3)).toSocialPost();

final List<SocialPost> multiplePosts = List<SocialPostDto>.from(
        jsonDecode(multiPostsJson).map((item) => SocialPostDto.fromJson(item)))
    .toSocialPosts();

final SocialPost singlePostWithComments1 =
    SocialPostDto.fromJson(jsonDecode(singlePostJson1))
        .toSocialPost([singleComment1]);

final SocialPost singlePostWithComments2 =
    SocialPostDto.fromJson(jsonDecode(singlePostJson2))
        .toSocialPost([singleComment2]);

final SocialPost singlePostWithComments3 =
    SocialPostDto.fromJson(jsonDecode(singlePostJson3))
        .toSocialPost([singleComment3]);

final SocialPost singlePostWithMultiComments =
    SocialPostDto.fromJson(jsonDecode(singlePostJson1))
        .toSocialPost(commentsForPost1);
