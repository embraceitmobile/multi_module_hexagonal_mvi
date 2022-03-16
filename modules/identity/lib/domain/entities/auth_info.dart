class AuthInfo {
  final int userId;
  final String accessToken;
  final String refreshToken;

  const AuthInfo({
    required this.userId,
    required this.accessToken,
    required this.refreshToken,
  });
}
