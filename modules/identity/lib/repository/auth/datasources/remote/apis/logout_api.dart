import 'package:core/models/network/base_response.dart';

const logoutEndpoint = "api/TokenAuth/Logout";

class LogoutResponse {
  final bool success;

  LogoutResponse(this.success);

  factory LogoutResponse.fromBaseResponse(BaseResponse response) =>
      LogoutResponse(response.success == true || response.result == true);
}
