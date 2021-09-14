import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';

class UserModel implements StateEntity {
  final int id;
  final String? name;
  final String? surname;
  final String? userName;
  final String? emailAddress;
  final String? address;
  final String? phoneNumber;
  final String? imagePath;
  final bool? isActive;

  final LocalState state;
  final String uniqueKey;

  const UserModel({
    required this.id,
    this.name,
    this.surname,
    this.userName,
    this.emailAddress,
    this.address,
    this.phoneNumber,
    this.imagePath,
    this.isActive,
    required this.state,
  }) : uniqueKey = '$id';

  factory UserModel.fromEntityMap(Map<String, dynamic> map) => UserModel(
        id: map["id"],
        name: map["name"],
        surname: map["surname"],
        emailAddress: map["emailAddress"],
        userName: map["userName"],
        address: map["address"],
        phoneNumber: map["phoneNumber"],
        imagePath: map["imagePath"],
        isActive: map["isActive"],
        state: (map["state"] as int).toState,
      );

  factory UserModel.loading(int userId) =>
      UserModel(id: userId, state: LocalState.loading);

  factory UserModel.failed(int userId) =>
      UserModel(id: userId, state: LocalState.failed);

  factory UserModel.fromUser(User user) => UserModel(
        id: user.id,
        name: user.name,
        surname: user.surname,
        userName: user.userName,
        emailAddress: user.emailAddress,
        address: user.address,
        phoneNumber: user.phoneNumber,
        imagePath: user.imagePath,
        isActive: true,
        state: LocalState.success,
      );

  @override
  Map<String, dynamic> toEntityMap() => {
        "id": id,
        "name": name,
        "surname": surname,
        "userName": userName,
        "emailAddress": emailAddress,
        "address": address,
        "phoneNumber": phoneNumber,
        "imagePath": imagePath,
        "state": state.toInt,
        Entity.unique_key: uniqueKey,
      };

  User? get toUser {
    switch (state) {
      case LocalState.success:
        return User(
          id: id,
          name: name ?? "",
          userName: userName ?? "",
          surname: surname ?? "",
          emailAddress: emailAddress ?? "",
          address: address ?? "",
          phoneNumber: phoneNumber ?? "",
          imagePath: imagePath ?? "",
        );
      case LocalState.loading:
      case LocalState.failed:
        return null;
    }
  }

  UserModel copyWith(
          {String? name,
          String? surname,
          String? userName,
          String? emailAddress,
          String? address,
          String? phoneNumber,
          String? imagePath,
          bool? isActive,
          LocalState? state}) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        surname: surname ?? this.surname,
        userName: userName ?? this.userName,
        emailAddress: emailAddress ?? this.emailAddress,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        imagePath: imagePath ?? this.imagePath,
        isActive: isActive ?? this.isActive,
        state: state ?? this.state,
      );
}
