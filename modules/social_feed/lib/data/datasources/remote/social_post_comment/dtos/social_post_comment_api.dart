import 'dart:convert';
import 'package:social_feed/domain/entities/social_post_comment.dart';

const getCommentsEndpoint = "/comments";

class GetCommentByIdRequest {
  final int commentId;

  const GetCommentByIdRequest(this.commentId);
}

class SocialPostCommentResponse extends SocialPostComment {
  const SocialPostCommentResponse({
    required int postId,
    required int id,
    required String name,
    required String email,
    required String body,
  }) : super(postId: postId, id: id, name: name, body: body, email: email);

  factory SocialPostCommentResponse.fromJson(String str) =>
      SocialPostCommentResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SocialPostCommentResponse.fromMap(Map<String, dynamic> json) =>
      SocialPostCommentResponse(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
      };
}
