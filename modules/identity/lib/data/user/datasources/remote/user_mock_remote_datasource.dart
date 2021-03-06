import 'package:core/core.dart';
import 'package:identity/data/user/datasources/remote/apis/update_profile_api.dart';
import 'package:injectable/injectable.dart';

import 'apis/get_user_api.dart';
import 'i_user_remote_datasource.dart';

@Singleton(as: IUserRemoteDatasource)
class UserMockRemoteDatasource implements IUserRemoteDatasource {
  static const String TAG = "RemoteUserDatasource";

  const UserMockRemoteDatasource(IRemoteApiClient<dynamic> _apiClient);

  Future<UserResponse> getActiveUser() async {
    await Future.delayed(Duration(milliseconds: 500));
    return UserResponse(
      id: 121,
      name: "User",
      username: "User123",
      email: "user@domain.com",
    );
  }

  /// Only works with userId = 121
  Future<UserResponse> getUserById(GetUserRequest request) async {
    await Future.delayed(Duration(milliseconds: 500));
    if (request.userId == 121)
      return UserResponse(
        id: 121,
        name: "User",
        username: "User123",
        email: "user@domain.com",
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
