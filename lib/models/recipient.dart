import 'package:json_annotation/json_annotation.dart';

part 'recipient.g.dart';

@JsonSerializable()
class Recipient {
Recipient({
  required this.recipientId,
  required this.name,
  required this.street,
  required this.city,
  required this.province,
  required this.zip,
  required this.phone,
  required this.email,
});

int recipientId;
String name;
String street;
String city;
String province;
String zip;
String phone;
String email;


factory Recipient.fromJson(Map<String, dynamic> json) => _$RecipientFromJson(json);

Map<String, dynamic>  toJson() => _$RecipientToJson(this);


}