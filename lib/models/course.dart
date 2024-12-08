import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  Course({
    required this.courseId,
    required this.name,
    required this.cost,
    required this.costFrequency,
  });

  int courseId;
  String name;
  double cost;
  String costFrequency;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
