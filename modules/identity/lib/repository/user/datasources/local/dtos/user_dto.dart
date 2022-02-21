import 'package:core/core.dart';
import 'package:identity/hexagon/entities/user.dart';
import 'package:identity/repository/user/datasources/remote/apis/get_user_api.dart';

class UserDto extends User implements Dto {
  final String uniqueKey;
  final AddressModel? address;
  final CompanyModel? company;

  const UserDto({
    required int id,
    required String username,
    String? email,
    this.address,
    this.company,
    String? name,
    String? phone,
    String? website,
    String? imageUrl,
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

  factory UserDto.fromEntityMap(Map<String, dynamic> map) => UserDto(
        id: map["id"],
        name: map["name"],
        username: map["username"],
        email: map["email"],
        address: map["address"] == null
            ? null
            : AddressModel.fromMap(map["address"]),
        phone: map["phone"],
        website: map["website"],
        company: map["company"] == null
            ? null
            : CompanyModel.fromMap(map["company"]),
        imageUrl: map["imageUrl"],
      );

  factory UserDto.fromUser(User user) => UserDto(
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        address: user.address == null
            ? null
            : AddressModel.fromAddress(user.address!),
        phone: user.phone,
        company: user.company == null
            ? null
            : CompanyModel.fromCompany(user.company!),
        website: user.website,
        imageUrl: user.imageUrl,
      );

  factory UserDto.fromUserResponse(UserResponse user) => UserDto(
        id: user.id,
        name: user.name,
        username: user.username,
        email: user.email,
        address: user.address == null
            ? null
            : AddressModel.fromAddress(user.address!),
        phone: user.phone,
        company: user.company == null
            ? null
            : CompanyModel.fromCompany(user.company!),
        website: user.website,
        imageUrl: user.imageUrl,
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

  factory AddressModel.fromMap(Map<String, dynamic> map) => AddressModel(
        street: map["street"],
        suite: map["suite"],
        city: map["city"],
        zipcode: map["zipcode"],
        geo: map["geo"] == null ? null : GeoCodesModel.fromMap(map["geo"]),
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

  factory GeoCodesModel.fromMap(Map<String, dynamic> map) => GeoCodesModel(
        lat: map["lat"],
        lng: map["lng"],
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

  factory CompanyModel.fromCompany(Company company) => CompanyModel(
        name: company.name,
        catchPhrase: company.catchPhrase,
        bs: company.bs,
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}
