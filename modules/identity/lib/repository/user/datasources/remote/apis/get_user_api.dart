import 'dart:convert';

import 'package:core/models/exceptions/invalid_data_exception.dart';
import 'package:identity/identity.dart';

const getUserByIdEndpoint = "/users";

class GetUserRequest {
  final int userId;

  const GetUserRequest(this.userId);

  Map<String, dynamic> get toMap => {"userId": userId};
}

class UserResponse extends User {
  const UserResponse({
    required int id,
    required username,
    required email,
    String? name,
    AddressResponse? address,
    String? phone,
    String? website,
    CompanyResponse? company,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
          address: address,
          phone: phone,
          website: website,
          company: company,
        );

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    if (map["id"] == null || map["username"] == null || map["email"] == null)
      throw InvalidDataException(
          "Invalid response received from server for GetUserResponse");

    return UserResponse(
      id: map["id"],
      name: map["name"],
      username: map["username"],
      email: map["email"],
      address: map["address"] == null
          ? null
          : AddressResponse.fromMap(map["address"]),
      phone: map["phone"],
      website: map["website"],
      company: map["company"] == null
          ? null
          : CompanyResponse.fromMap(map["company"]),
    );
  }

  factory UserResponse.fromJson(String? str) {
    if (str == null || str.isEmpty)
      throw InvalidDataException(
          "Invalid response received from server for GetUserResponse");

    return UserResponse.fromMap(json.decode(str));
  }
}

class AddressResponse extends Address {
  AddressResponse({
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
  final GeoResponse? geo;

  factory AddressResponse.fromMap(Map<String, dynamic> json) => AddressResponse(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: GeoResponse.fromMap(json["geo"]),
      );
}

class GeoResponse extends GeoCodes {
  GeoResponse({
    required this.lat,
    required this.lng,
  }) : super(lat: lat, lng: lng);

  final String lat;
  final String lng;

  factory GeoResponse.fromMap(Map<String, dynamic> json) => GeoResponse(
        lat: json["lat"],
        lng: json["lng"],
      );
}

class CompanyResponse extends Company {
  CompanyResponse({
    required String name,
    String? catchPhrase,
    String? bs,
  }) : super(name: name, catchPhrase: catchPhrase, bs: bs);

  factory CompanyResponse.fromMap(Map<String, dynamic> json) => CompanyResponse(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );
}
