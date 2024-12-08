import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/course_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';

class CourseListBuilder extends ConsumerWidget {
  CourseListBuilder({super.key, required this.courses});

  final List<Course> courses;

  late AppData provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref.watch(appData);

    return ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          Course item = courses[index];

          return CourseTile(
            course: item,
            isLastIndex: index == courses.length - 1,
            onTapDelete: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogTile(
                      affirmButtonText: "Yes",
                      cancelButtonText: 'No',
                      dialogTitle:
                          "Are you sure you want to\n delete this course?",
                      onTapAffirm: () async {
                        await provider.deleteCourse(
                            context: context, courseId: item.courseId);

                        if (context.mounted) {
                          Navigator.pop(context);
                        }
                      },
                      onTapCancel: () {
                        Navigator.pop(context);
                      },
                    );
                  });
            },
            onTapEdit: () => showDialog<String>(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) => DialogTile(
                      dialogTitle: "Edit Course",
                      dialogHeight: 200,
                      affirmButtonText: "Update",
                      cancelButtonText: "Cancel",
                      onTapCancel: () {
                        Navigator.pop(context);
                      },
                      onTapAffirm: null,
                    )),
          );
        });
  }
}
