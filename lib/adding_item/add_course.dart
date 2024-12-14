import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dialogs/course_dialog.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';

class AddCourse extends ConsumerStatefulWidget {
  const AddCourse({super.key});

  @override
  ConsumerState<AddCourse> createState() => _AddCourseConsumerState();
}

class _AddCourseConsumerState extends ConsumerState<AddCourse> {
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

    return CourseDialog(
      formKey: formKey,
      costController: costController,
      frequencyController: frequencyController,
      nameController: nameController,
      onTapAffirm: () async {
        if (formKey.currentState!.validate()) {
          loadCircle();
          await provider.insertCourse(
            context: context,
            name: nameController.text,
            cost: double.parse(costController.text),
            frequency: frequencyController.text,
          );
          loadCircle();

          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
    );
  }
}
