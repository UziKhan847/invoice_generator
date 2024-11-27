import 'package:json_annotation/json_annotation.dart';

part 'receipt.g.dart';

@JsonSerializable(explicitToJson: true)
class Receipt {
  Receipt({
    required this.receiptId,
    required this.receiptDate,
    required this.paid,
    required this.invoiceId,
  });

  @JsonKey(name: 'receipt_id')
  int receiptId;

  @JsonKey(name: 'receipt_date')
  String receiptDate;

  double paid;

  @JsonKey(name: 'invoice_id')
  int invoiceId;

  factory Receipt.fromJson(Map<String, dynamic> json) =>
      _$ReceiptFromJson(json);

  Map<String, dynamic> toJson() => _$ReceiptToJson(this);
}
