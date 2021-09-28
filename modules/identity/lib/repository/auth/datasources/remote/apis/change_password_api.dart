const changePasswordEndpoint = "api/TokenAuth/ChangePassword";

class ChangePasswordRequest {
  final String currentPassword;
  final String newPassword;

  ChangePasswordRequest(this.currentPassword, this.newPassword);

  Map<String, dynamic> toMap() =>
      {"CurrentPassword": currentPassword, "NewPassword": newPassword};
}

class ChangePasswordResponse {
  final bool success;

  ChangePasswordResponse(this.success);

  factory ChangePasswordResponse.response(dynamic response) =>
      ChangePasswordResponse(response == true);
}
