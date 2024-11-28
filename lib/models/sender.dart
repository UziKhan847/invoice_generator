import 'package:json_annotation/json_annotation.dart';

part 'sender.g.dart';

@JsonSerializable()
class Sender {
  Sender({
    required this.senderId,
    required this.name,
    required this.businessNumber,
    required this.street,
    required this.city,
    required this.province,
    required this.zip,
    required this.phone,
    required this.email,
    required this.eTransfer,
  });

  int senderId;
  String businessNumber;
  String name;
  String street;
  String city;
  String province;
  String zip;
  String phone;
  String email;
  String? eTransfer;

  factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);

  Map<String, dynamic> toJson() => _$SenderToJson(this);
}
