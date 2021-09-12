class User {
  final int id;
  final String name;
  final String surname;
  final String userName;
  final String emailAddress;
  final String address;
  final String phoneNumber;
  final String imagePath;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.userName,
    required this.emailAddress,
    required this.address,
    required this.phoneNumber,
    required this.imagePath,
  });

  User copyWith({
    String? name,
    String? userName,
    String? surName,
    String? emailAddress,
    String? address,
    String? phoneNumber,
    String? imagePath,
    bool? isFirstLogin,
    bool? isActive,
  }) =>
      User(
        id: this.id,
        name: name ?? this.name,
        surname: surName ?? this.surname,
        userName: userName ?? this.userName,
        emailAddress: emailAddress ?? this.emailAddress,
        address: address ?? this.address,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        imagePath: imagePath ?? this.imagePath,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          surname == other.surname &&
          userName == other.userName &&
          emailAddress == other.emailAddress &&
          address == other.address &&
          phoneNumber == other.phoneNumber &&
          imagePath == other.imagePath;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      surname.hashCode ^
      userName.hashCode ^
      emailAddress.hashCode ^
      address.hashCode ^
      phoneNumber.hashCode ^
      imagePath.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name, surname: $surname, userName: $userName, emailAddress: $emailAddress, address: $address, phoneNumber: $phoneNumber, imagePath: $imagePath }';
  }
}
