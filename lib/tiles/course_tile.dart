import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class CourseTile extends StatelessWidget {
  const CourseTile({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.my_library_books,
              size: 20,
            ),
            title: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      "Course Id: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${course.courseId}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Course Name: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      course.name,
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Course Cost: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${course.cost}/${course.costFrequency}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Course Quantity: ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${course.quantity}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
                Margins.vertical4,
                Row(
                  children: [
                    const Text(
                      "Total Amount (Excluding Tax): ",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "\$${course.amount}",
                      style: const TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            height: 0,
          ),
        ],
      ),
    );
  }
}
