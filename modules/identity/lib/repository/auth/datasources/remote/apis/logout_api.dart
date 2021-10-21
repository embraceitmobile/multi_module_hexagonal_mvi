import 'package:core/models/network/base_response.dart';

const logoutEndpoint = "/Logout";

class LogoutResponse {
  final bool success;

  const LogoutResponse(this.success);

  factory LogoutResponse.fromBaseResponse(BaseResponse response) =>
      LogoutResponse(response.success == true || response.result == true);
}
