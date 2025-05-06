import 'package:json_annotation/json_annotation.dart';

part 'sender.g.dart';

@JsonSerializable()
class Sender {
  Sender({
    required this.senderId,
    required this.name,
    required this.position,
    required this.phone,
    required this.email,
    required this.eTransfer,
  });

  int senderId;  
  String name;
  String position;
  String? phone;
  String? email;
  String? eTransfer;

  factory Sender.fromJson(Map<String, dynamic> json) => _$SenderFromJson(json);

  Map<String, dynamic> toJson() => _$SenderToJson(this);
}
