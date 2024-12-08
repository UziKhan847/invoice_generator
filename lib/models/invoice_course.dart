import 'package:json_annotation/json_annotation.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';

part 'invoice_course.g.dart';

@JsonSerializable()
class InvoiceCourse {
  InvoiceCourse({
    required this.courses,
    required this.quantity,
    required this.amount,
  });

  Course courses;
  double quantity;
  double amount;

  factory InvoiceCourse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceCourseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceCourseToJson(this);
}
