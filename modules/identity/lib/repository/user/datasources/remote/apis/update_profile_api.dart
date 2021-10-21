import 'dart:io';

import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';

const updateUserProfileEndpoint =
    "api/ServiceWorker/UpdateServiceWorkerProfile";

class UpdateUserProfileRequest {
  final String? name;
  final Address? address;
  final String? phoneNumber;
  final File? file;
  final String? fileName;

  const UpdateUserProfileRequest({
    this.name,
    this.address,
    this.phoneNumber,
    this.file,
    this.fileName,
  });

  factory UpdateUserProfileRequest.fromUser(User user) {
    return UpdateUserProfileRequest(
      name: user.name,
      address: user.address,
      phoneNumber: user.phone,
    );
  }

  FormData get toFormData => FormData.fromMap(
        {
          "name": name,
          "address": address,
          "phoneNumber": phoneNumber,
          "file": file == null
              ? null
              : MultipartFile.fromFileSync(file!.path, filename: fileName)
        },
      );
}

class UpdateUserProfileResponse {
  final bool success;

  const UpdateUserProfileResponse(this.success);

  factory UpdateUserProfileResponse.response(dynamic response) =>
      UpdateUserProfileResponse(response == true);
}
