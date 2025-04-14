import 'package:json_annotation/json_annotation.dart';

part 'country_code.g.dart';

@JsonSerializable()
class CountryCode {
  CountryCode({
    required this.isoTwo,
    required this.isoThree,
  });

  @JsonKey(name: 'iso_two')
  String isoTwo;

  @JsonKey(name: 'iso_three')
  String isoThree;

  factory CountryCode.fromJson(Map<String, dynamic> json) =>
      _$CountryCodeFromJson(json);

  Map<String, dynamic> toJson() => _$CountryCodeToJson(this);
}
