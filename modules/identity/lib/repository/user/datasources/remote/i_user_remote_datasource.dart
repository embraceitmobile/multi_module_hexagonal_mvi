import 'package:identity/repository/user/datasources/remote/apis/get_user_api.dart';
import 'package:identity/repository/user/datasources/remote/apis/update_profile_api.dart';

abstract class IRemoteUserDatasource {
  Future<GetUserResponse> getActiveUser();

  Future<UpdateUserProfileResponse> updateUserProfile(
      UpdateUserProfileRequest request);
}
