import 'package:identity/data/user/datasources/remote/dtos/update_profile_api.dart';

import 'dtos/get_user_api.dart';

abstract class IUserRemoteDatasource {
  Future<UserResponse> getUserById(GetUserRequest request);

  Future<UpdateUserProfileResponse> updateUserProfile(
      UpdateUserProfileRequest request);
}
