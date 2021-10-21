import 'package:identity/repository/user/datasources/remote/apis/update_profile_api.dart';

import 'apis/get_user_api.dart';

abstract class IUserRemoteDatasource {
  Future<UserResponse> getUserById(GetUserRequest request);

  Future<UpdateUserProfileResponse> updateUserProfile(
      UpdateUserProfileRequest request);
}
