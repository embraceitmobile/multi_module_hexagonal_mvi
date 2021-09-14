import 'dart:io';

import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';
import 'package:path/path.dart';

const updateUserProfileEndpoint =
    "api/ServiceWorker/UpdateServiceWorkerProfile";

class UpdateUserProfileRequest {
  final String? name;
  final String? address;
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
    final file = user.imagePath.isEmpty ? null : File(user.imagePath);
    return UpdateUserProfileRequest(
      name: user.name,
      address: user.address,
      phoneNumber: user.phoneNumber,
      fileName: file == null ? "" : '${user.userName}_${basename(file.path)}',
      file: file,
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

  factory UpdateUserProfileResponse.fromBaseResponse(BaseResponse response) =>
      UpdateUserProfileResponse(
          response.success == true || response.result == true);
}
