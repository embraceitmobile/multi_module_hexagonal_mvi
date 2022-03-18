import 'dart:convert';

import 'package:social_feed/social_feed.dart';

const getPostsEndpoint = "/posts";

class GetPostByIdRequest {
  final int postId;

  const GetPostByIdRequest(this.postId);
}

class SocialPostResponse extends SocialPost {
  const SocialPostResponse({
    required int userId,
    required int id,
    required String title,
    required String body,
  }) : super(id: id, userId: userId, title: title, body: body);

  factory SocialPostResponse.fromJson(String str) =>
      SocialPostResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialPostResponse.fromMap(Map<String, dynamic> json) =>
      SocialPostResponse(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
