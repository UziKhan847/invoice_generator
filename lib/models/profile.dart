import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable()
class Profile {
  Profile({
    required this.businessNumber,
    required this.street,
    required this.city,
    required this.province,
    required this.country,
    required this.zip,
    required this.phone,
    required this.email,
    required this.fullName,
    required this.currency,
    required this.website,
    required this.logoUrl,
  });

  @JsonKey(name: 'full_name')
  String? fullName;

  @JsonKey(name: 'business_number')
  String? businessNumber;

  String? country;
  String? province;
  String? city;
  String? street;
  String? zip;
  String? phone;
  String? email;
  String? currency;
  String? website;

  @JsonKey(name: 'logo_url')
  String? logoUrl;

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);

  bool get isIncomplete {
    return [
      fullName,
      country,
      province,
      city,
      street,
      email,
      phone,
      currency,
    ].any((field) => field == null);
  }
}
