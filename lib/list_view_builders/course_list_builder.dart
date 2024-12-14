import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/course_tile.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';

class CourseListBuilder extends ConsumerStatefulWidget {
  const CourseListBuilder({super.key, required this.courses});

  final List<Course> courses;

  @override
  ConsumerState<CourseListBuilder> createState() =>
      _CourseListBuilderConsumerState();
}

class _CourseListBuilderConsumerState extends ConsumerState<CourseListBuilder> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final costController = TextEditingController();
  final frequencyController = TextEditingController();
  final nameController = TextEditingController();
  late AppData provider;

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    frequencyController.dispose();
    super.dispose();
  }

  void loadCircle() => setState(() {
        isLoading = !isLoading;
      });

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);

    return ListView.builder(
        padding: const EdgeInsets.only(top: 0, bottom: 0),
        itemCount: widget.courses.length,
        itemBuilder: (context, index) {
          Course item = widget.courses[index];

          //         nameController.text = item.name;
          // costController.text = "${item.cost}";
          // frequencyController.text = item.costFrequency;

          return CourseTile(
            course: item,
            isLastIndex: index == widget.courses.length - 1,
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
            // onTapEdit: () => showDialog<String>(
            //     barrierDismissible: false,
            //     context: context,
            //     builder: (BuildContext context) => CourseDialog(
            //           formKey: formKey,
            //           item: item,
            //           costController: costController,
            //           nameController: nameController,
            //           frequencyController: frequencyController,
            //           onTapAffirm: () async {
            //             loadCircle();
            //             await provider.updateCourse(
            //               context: context,
            //               courseId: item.courseId,
            //               name: nameController.text,
            //               cost: double.parse(costController.text),
            //               frequency: frequencyController.text,
            //             );
            //             loadCircle();

            //             if (context.mounted) {
            //               Navigator.pop(context);
            //             }
            //           },
            //         )),
          );
        });
  }
}
