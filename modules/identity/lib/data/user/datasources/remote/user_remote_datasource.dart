import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:identity/data/user/datasources/remote/apis/update_profile_api.dart';
import 'package:identity/data/user/datasources/remote/i_user_remote_datasource.dart';
import 'package:injectable/injectable.dart';

import 'apis/get_user_api.dart';

@Singleton(as: IUserRemoteDatasource)
class UserRemoteDatasource implements IUserRemoteDatasource {
  static const String TAG = "RemoteUserDatasource";

  final IRemoteApiClient<dynamic> _apiClient;

  // injecting api client instance
  const UserRemoteDatasource(this._apiClient);

  Future<UserResponse> getUserById(GetUserRequest request) async {
    try {
      final response = await _apiClient.get(getUserByIdEndpoint);

      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      final users = response as List<dynamic>;
      final user =
          users.firstWhereOrNull((element) => element["id"] == request.userId);

      if (user == null)
        throw NetworkException(ErrorResponse(
            statusCode: 400,
            message:
                "Unable to find user details for userId: ${request.userId}"));

      user["imageUrl"] =
          _avatars[((_avatars.length - 1) % (user["id"] as int))];

      return UserResponse.fromMap(user);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  Future<UpdateUserProfileResponse> updateUserProfile(
      UpdateUserProfileRequest request) async {
    try {
      final response = await _apiClient.post(updateUserProfileEndpoint,
          data: request.toFormData);
      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      return UpdateUserProfileResponse.response(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }
}

const _avatars = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqGQ8dQ-LMiMmTEyBijR0FzpQHC7tH6qTE2g&usqp=CAU",
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQZldEPvFgz5ysckNAa5ztdf4Exw00bb1a9qA&usqp=CAU",
  "https://www.shareicon.net/data/512x512/2016/09/15/829452_user_512x512.png"
];
