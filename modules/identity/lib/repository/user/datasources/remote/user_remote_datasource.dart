import 'package:core/core.dart';
import 'package:identity/repository/user/datasources/remote/apis/get_user_api.dart';
import 'package:identity/repository/user/datasources/remote/apis/update_profile_api.dart';
import 'package:identity/repository/user/datasources/remote/i_user_remote_datasource.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: IUserRemoteDatasource)
class UserRemoteDatasource implements IUserRemoteDatasource {
  static const String TAG = "RemoteUserDatasource";

  final IRemoteApiClient<dynamic> _apiClient;

  // injecting api client instance
  const UserRemoteDatasource(this._apiClient);

  Future<GetUserResponse> getUserById(GetUserRequest request) async {
    try {
      final response =
          await _apiClient.post(getUserByIdEndpoint, data: request.toMap);

      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      return GetUserResponse.fromMap(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }

  Future<GetUserResponse> getActiveUser() async {
    try {
      final response = await _apiClient.get(getUserEndpoint);

      if (response == null)
        throw InvalidDataException("Invalid response received from server");

      return GetUserResponse.fromMap(response);
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

      return UpdateUserProfileResponse.fromBaseResponse(response);
    } on InvalidDataException {
      rethrow;
    } on NetworkException {
      rethrow;
    } on Exception catch (ex) {
      throw NetworkException.fromException(ex);
    }
  }
}
