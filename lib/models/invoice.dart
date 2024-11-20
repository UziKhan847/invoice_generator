import 'package:json_annotation/json_annotation.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';

part 'invoice.g.dart';

@JsonSerializable(explicitToJson: true)
class Invoice {
  Invoice({
    required this.invoiceId,
    required this.invoiceDate,
    required this.dueDate,
    required this.subtotal,
    required this.hst,
    required this.total,
    required this.senderId,
    required this.senders,
    required this.recipientId,
    required this.recipients,
    required this.courses,
  });

  @JsonKey(name: 'invoice_id')
  int invoiceId;

  @JsonKey(name: 'invoice_date')
  String invoiceDate;

  @JsonKey(name: 'due_date')
  String? dueDate;

  double subtotal;
  double? hst;
  double total;

  @JsonKey(name: 'sender_id')
  int senderId;
  Sender senders;

  @JsonKey(name: 'recipient_id')
  int recipientId;
  Recipient recipients;

  List<Course> courses;

  factory Invoice.fromJson(Map<String, dynamic> json) =>
      _$InvoiceFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceToJson(this);
}
