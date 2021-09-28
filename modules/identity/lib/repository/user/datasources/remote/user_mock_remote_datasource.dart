import 'package:core/clients/remote_api_client/base/i_remote_api_client.dart';
import 'package:core/core.dart';
import 'package:identity/repository/user/datasources/remote/apis/get_user_api.dart';
import 'package:identity/repository/user/datasources/remote/apis/update_profile_api.dart';
import 'package:injectable/injectable.dart';

import 'i_user_remote_datasource.dart';

@Singleton(as: IUserRemoteDatasource)
class UserMockRemoteDatasource implements IUserRemoteDatasource {
  static const String TAG = "RemoteUserDatasource";

  const UserMockRemoteDatasource(IRemoteApiClient<dynamic> _apiClient);

  Future<GetUserResponse> getActiveUser() async {
    await Future.delayed(Duration(milliseconds: 500));
    return GetUserResponse(
      id: 121,
      name: "User",
      emailAddress: "user@domain.com",
    );
  }

  /// Only works with userId = 121
  Future<GetUserResponse> getUserById(GetUserRequest request) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (request.userId == 121)
      return GetUserResponse(
        id: 121,
        name: "User",
        emailAddress: "user@domain.com",
      );
    else
      throw NetworkException(
        ErrorResponse(
            message: "Unable to find userId=${request.userId}",
            statusCode: 400),
      );
  }

  Future<UpdateUserProfileResponse> updateUserProfile(
      UpdateUserProfileRequest request) async {
    await Future.delayed(Duration(milliseconds: 500));
    return UpdateUserProfileResponse(true);
  }
}
