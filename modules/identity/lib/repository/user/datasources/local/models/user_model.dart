import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';
import 'package:identity/repository/user/datasources/remote/apis/get_user_api.dart';

class UserModel extends User implements Dto {
  final bool? isActive;
  final String uniqueKey;
  final AddressModel? address;

  const UserModel({
    required int id,
    required String username,
    required String email,
    this.address,
    String? name,
    String? phone,
    Company? company,
    String? website,
    String? imageUrl,
    this.isActive,
  })  : uniqueKey = '$id',
        super(
          id: id,
          name: name,
          username: username,
          email: email,
          address: address,
          phone: phone,
          company: company,
          website: website,
          imageUrl: imageUrl,
        );

  factory UserModel.fromEntityMap(Map<String, dynamic> map) => UserModel(
        id: map["id"],
        name: map["name"],
        username: map["username"],
        email: map["email"],
        address: map["address"] == null
            ? null
            : AddressModel.fromMap(map["address"]),
        phone: map["phone"],
        website: map["website"],
        company: map["company"],
        isActive: map["isActive"],
        imageUrl: map["imageUrl"],
      );

  factory UserModel.fromUser(User user) => UserModel(
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        address: user.address == null
            ? null
            : AddressModel.fromAddress(user.address!),
        phone: user.phone,
        company: user.company,
        website: user.website,
        imageUrl: user.imageUrl,
        isActive: true,
      );

  factory UserModel.fromUserResponse(UserResponse user) => UserModel(
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        address: user.address == null
            ? null
            : AddressModel.fromAddress(user.address!),
        phone: user.phone,
        company: user.company,
        website: user.website,
        imageUrl: user.imageUrl,
        isActive: true,
      );

  @override
  Map<String, dynamic> toDtoMap() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "address": address?.toMap(),
        "phone": phone,
        "company": company?.toMap(),
        "imageUrl": imageUrl,
        Dto.unique_key: uniqueKey,
      };
}

class AddressModel extends Address {
  final GeoCodesModel? geo;

  const AddressModel({
    String? street,
    String? suite,
    String? city,
    String? zipcode,
    this.geo,
  }) : super(
          street: street,
          suite: suite,
          city: city,
          zipcode: zipcode,
          geo: geo,
        );

  factory AddressModel.fromMap(Map<String, dynamic> json) => AddressModel(
        street: json["street"],
        suite: json["suite"],
        city: json["city"],
        zipcode: json["zipcode"],
        geo: GeoCodesModel.fromMap(json["geo"]),
      );

  factory AddressModel.fromAddress(Address address) => AddressModel(
        street: address.street,
        suite: address.suite,
        city: address.city,
        zipcode: address.zipcode,
        geo: address.geo == null
            ? null
            : GeoCodesModel.fromGeoCodes(address.geo!),
      );

  Map<String, dynamic> toMap() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo?.toMap(),
      };
}

class GeoCodesModel extends GeoCodes {
  GeoCodesModel({required String lat, required String lng})
      : super(lat: lat, lng: lng);

  factory GeoCodesModel.fromMap(Map<String, dynamic> json) => GeoCodesModel(
        lat: json["lat"],
        lng: json["lng"],
      );

  factory GeoCodesModel.fromGeoCodes(GeoCodes geoCodes) => GeoCodesModel(
        lat: geoCodes.lat,
        lng: geoCodes.lng,
      );

  Map<String, dynamic> toMap() => {
        "lat": lat,
        "lng": lng,
      };
}

class CompanyModel extends Company {
  const CompanyModel({
    required String name,
    String? catchPhrase,
    String? bs,
  }) : super(name: name, catchPhrase: catchPhrase, bs: bs);

  factory CompanyModel.fromMap(Map<String, dynamic> json) => CompanyModel(
        name: json["name"],
        catchPhrase: json["catchPhrase"],
        bs: json["bs"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}
