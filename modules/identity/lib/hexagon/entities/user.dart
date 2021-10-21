class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address? address;
  final Company? company;
  final String? phone;
  final String? website;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.address,
    this.phone,
    this.company,
    this.website,
  });

  User copyWith({
    String? name,
    String? username,
    String? email,
    Address? address,
    Company? company,
    String? phone,
    String? website,
  }) =>
      User(
        id: this.id,
        name: name ?? this.name,
        username: username ?? this.username,
        email: email ?? this.email,
        address: address ?? this.address,
        phone: phone ?? this.phone,
        company: company ?? this.company,
        website: website ?? this.website,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          username == other.username &&
          email == other.email &&
          address == other.address &&
          company == other.company &&
          phone == other.phone &&
          website == other.website;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      username.hashCode ^
      email.hashCode ^
      address.hashCode ^
      company.hashCode ^
      phone.hashCode ^
      website.hashCode;

  @override
  String toString() {
    return 'User{id: $id, name: $name, username: $username, email: $email, address: $address, company: $company, phone: $phone, website: $website}';
  }
}

class Address {
  const Address({
    this.street,
    this.suite,
    this.city,
    this.zipcode,
    this.geo,
  });

  final String? street;
  final String? suite;
  final String? city;
  final String? zipcode;
  final GeoCodes? geo;
}

class GeoCodes {
  const GeoCodes({required this.lat, required this.lng});

  final String lat;
  final String lng;
}

class Company {
  const Company({
    required this.name,
    this.catchPhrase,
    this.bs,
  });

  final String name;
  final String? catchPhrase;
  final String? bs;

  factory Company.fromMap(Map<String, dynamic> json) => Company(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );
}
