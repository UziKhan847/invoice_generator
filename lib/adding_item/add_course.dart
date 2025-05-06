import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/addding_form_fields/course_form_fields.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';

class AddCourse extends ConsumerStatefulWidget {
  const AddCourse({super.key});

  @override
  ConsumerState<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends ConsumerState<AddCourse> {
  bool isLoading = false;
  late final formKey = GlobalKey<FormState>();
  late final Map<String, TextEditingController> controllers = {
    'name': TextEditingController(),
    'cost': TextEditingController(),
    'frequency': TextEditingController(),
  };
  late AppData provider;

  @override
  void dispose() {
    for (TextEditingController e in controllers.values) {
      e.dispose();
    }
    super.dispose();
  }

  void loadCircle() => setState(() {
        isLoading = !isLoading;
      });

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);

    return CourseFormFields(
      formKey: formKey,
      controllers: controllers,
      onTapAffirm: () async {
        if (formKey.currentState!.validate()) {
          loadCircle();
          await provider.insertCourse(
            context: context,
            name: controllers['name']!.text,
            cost: double.parse(controllers['cost']!.text),
            frequency: controllers['frequency']!.text,
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
