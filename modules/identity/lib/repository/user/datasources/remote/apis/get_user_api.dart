import 'dart:convert';

import 'package:core/models/exceptions/invalid_data_exception.dart';

const getUserEndpoint = "api/ServiceWorker/GetProfile";
const getUserByIdEndpoint = "api/ServiceWorker/GetProfile";

class GetUserRequest {
  final int userId;

  const GetUserRequest(this.userId);

  Map<String, dynamic> get toMap => {"userId": userId};
}

class GetUserResponse {
  final int id;
  final String? name;
  final String? surname;
  final String? userName;
  final String? emailAddress;
  final bool? isFirstLogin;
  final String? address;
  final String? phoneNumber;
  final String? imagePath;
  final bool? isActive;

  const GetUserResponse({
    required this.id,
    this.name,
    this.surname,
    this.userName,
    this.emailAddress,
    this.address,
    this.phoneNumber,
    this.imagePath,
    this.isFirstLogin,
    this.isActive,
  });

  factory GetUserResponse.fromMap(Map<String, dynamic> map) {
    final userMap = map["user"];
    if (userMap == null || userMap["id"] == null)
      throw InvalidDataException(
          "Invalid response received from server for GetUserResponse");

    return GetUserResponse(
      id: userMap["id"],
      name: userMap["name"],
      surname: userMap["surname"],
      userName: userMap["userName"],
      emailAddress: userMap["emailAddress"],
      address: userMap["address"],
      phoneNumber: userMap["phoneNumber"],
      imagePath: userMap["imagePath"],
      isFirstLogin: userMap["isFirstLogin"],
      isActive: userMap["isActive"],
    );
  }

  factory GetUserResponse.fromJson(String? str) {
    if (str == null || str.isEmpty)
      throw InvalidDataException(
          "Invalid response received from server for GetUserResponse");

    return GetUserResponse.fromMap(json.decode(str));
  }
}
