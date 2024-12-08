import 'package:json_annotation/json_annotation.dart';
import 'package:markaz_umaza_invoice_generator/models/invoice.dart';

part 'receipt.g.dart';

@JsonSerializable(explicitToJson: true)
class Receipt {
  Receipt({
    required this.receiptId,
    required this.receiptDate,
    required this.paid,
    required this.invoices,
  });

  int receiptId;
  String receiptDate;
  double paid;
  Invoice invoices;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
