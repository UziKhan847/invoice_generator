import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/tiles/course_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/recipient_tile.dart';

class CourseListBuilder extends StatelessWidget {
  CourseListBuilder({super.key, required this.courses});

  List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        itemCount: courses.length,
        itemBuilder: (context, index) => CourseTile(
              course: courses[index],
            ));
  }
}
