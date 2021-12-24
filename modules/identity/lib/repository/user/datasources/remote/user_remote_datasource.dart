import 'package:collection/collection.dart';
import 'package:core/core.dart';
import 'package:identity/repository/user/datasources/remote/apis/update_profile_api.dart';
import 'package:identity/repository/user/datasources/remote/i_user_remote_datasource.dart';
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
