import 'package:json_annotation/json_annotation.dart';
import 'package:markaz_umaza_invoice_generator/models/country_code.dart';
import 'package:markaz_umaza_invoice_generator/models/province.dart';

part 'country.g.dart';

@JsonSerializable(explicitToJson: true)
class Country {
  Country({
    required this.name,
    required this.provinces,
    required this.phoneRegex,
    required this.postalCodeRegex,
    required this.countryCode,
    required this.currency,
    required this.flagIcon,
  });

  String name;
  List<Province> provinces;

  @JsonKey(name: 'phone_regex')
  String? phoneRegex;

  @JsonKey(name: 'postal_code_regex')
  String? postalCodeRegex;

  @JsonKey(name: 'country_code')
  CountryCode countryCode;

  String currency;

  @JsonKey(name: 'flag_icon')
  String flagIcon;

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}