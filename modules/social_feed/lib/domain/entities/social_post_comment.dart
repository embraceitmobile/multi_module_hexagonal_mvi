class SocialPostComment {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const SocialPostComment({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  @override
  String toString() {
    return 'SocialPostComment{postId: $postId, id: $id, name: $name, email: $email, body: $body}';
  }
}
