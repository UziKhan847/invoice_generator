import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  Course({
    required this.courseId,
    required this.name,
    required this.cost,
    required this.costFrequency,
    required this.quantity,
    required this.amount,
  });

  int courseId;
  String name;
  double cost;
  String costFrequency;
  int quantity;
  double amount;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
