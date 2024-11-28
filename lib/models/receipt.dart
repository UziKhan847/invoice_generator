import 'package:json_annotation/json_annotation.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';

part 'receipt.g.dart';

@JsonSerializable(explicitToJson: true)
class Receipt {
  Receipt({
    required this.receiptId,
    required this.receiptDate,
    required this.paid,
    required this.invoiceId,
     required this.invoices,
     required this.senderId,
    required this.senders,
    required this.recipientId,
    required this.recipients,
    required this.courses,
  });

  int receiptId;
  String receiptDate;
  double paid;
  int invoiceId;
  Invoice invoices;
  int senderId;
  Sender senders;
  int recipientId;
  Recipient recipients;

  List<Course> courses;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
