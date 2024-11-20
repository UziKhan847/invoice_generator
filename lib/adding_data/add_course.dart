import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddCourse extends ConsumerStatefulWidget {
  const AddCourse({super.key});

  @override
  ConsumerState<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends ConsumerState<AddCourse> {
  final nameController = TextEditingController();
  final costController = TextEditingController();
  final frequencyController = TextEditingController();
  final quantityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedFrequency = 'Hr';
  String selectedQuantity = '1';
  bool isFrequencySelected = false;
  bool isQuantitySelected = false;
  List<String> frequencyDropdowItems = ["Hr", "Day", "Wk", "Mo", "Yr"];
  List<int> quantityDropdownItems =
      List<int>.generate(99, (int index) => index + 1, growable: false);
  late AppData provider;

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    frequencyController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void insertOverlay() {}

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);

    return AlertDialog(
      insetPadding: const EdgeInsets.all(12),
      title: const Text(
        "Add Course",
        style: TextStyle(fontSize: 20),
      ),
      content: SizedBox(
        height: 140,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter course name';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: "Course Name",
                ),
              ),
              Margins.vertical32,
              Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: TextFormField(
                      controller: costController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter cost';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        isDense: true,
                        labelText: "Cost (CAD)",
                      ),
                    ),
                  ),
                  Margins.horizontal10,
                  Stack(
                    children: [
                      SizedBox(
                        width: 64,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Frequency",
                            labelStyle: const TextStyle(fontSize: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            selectedFrequency,
                            style: const TextStyle(
                                fontSize: 17, color: Color(0xFF424242)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 2,
                        child: isFrequencySelected
                            ? const Icon(Icons.arrow_drop_up)
                            : const Icon(Icons.arrow_drop_down),
                      ),
                      Container(
                        height: 47,
                        width: 64,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        child: InkWell(onTap: () {
                          setState(() {
                            isFrequencySelected = !isFrequencySelected;
                          });
                          context.insertOverlay(
                            context,
                            height: 250,
                            width: 62,
                            bottom: 62,
                            right: 126.5,
                            onTapRemove: () {
                              setState(() {
                                isFrequencySelected = !isFrequencySelected;
                              });
                              context.removeOverlay();
                            },
                            listViewBuilder: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: frequencyDropdowItems.length,
                                itemBuilder: (context, index) {
                                  String item = frequencyDropdowItems[index];

                                  return Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 242, 242, 242),
                                          borderRadius: () {
                                            if (index == 0) {
                                              return const BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  topRight: Radius.circular(4));
                                            } else if (index ==
                                                frequencyDropdowItems.length -
                                                    1) {
                                              return const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4));
                                            }
                                            return BorderRadius.circular(0);
                                          }()),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkResponse(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          highlightShape: BoxShape.rectangle,
                                          onTap: () {
                                            setState(() {
                                              selectedFrequency = item;
                                              isFrequencySelected =
                                                  !isFrequencySelected;
                                            });
                                            context.removeOverlay();
                                          },
                                          child: Center(child: Text(item)),
                                        ),
                                      ));
                                }),
                          );
                        }),
                      )
                    ],
                  ),
                  Margins.horizontal10,
                  Stack(
                    children: [
                      SizedBox(
                        width: 55,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: "Quantity",
                            labelStyle: const TextStyle(fontSize: 10),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          child: Text(
                            selectedQuantity,
                            style: const TextStyle(
                                fontSize: 17, color: Color(0xFF424242)),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 2,
                        child: isQuantitySelected
                            ? const Icon(Icons.arrow_drop_up)
                            : const Icon(Icons.arrow_drop_down),
                      ),
                      Container(
                        height: 47,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                        child: InkWell(onTap: () {
                          setState(() {
                            isQuantitySelected = !isQuantitySelected;
                          });
                          context.insertOverlay(
                            context,
                            height: 312,
                            width: 55,
                            bottom: 0,
                            right: 60.5,
                            onTapRemove: () {
                              setState(() {
                                isQuantitySelected = !isQuantitySelected;
                              });
                              context.removeOverlay();
                            },
                            listViewBuilder: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: quantityDropdownItems.length,
                                itemBuilder: (context, index) {
                                  int item = quantityDropdownItems[index];

                                  return Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 242, 242, 242),
                                          borderRadius: () {
                                            if (index == 0) {
                                              return const BorderRadius.only(
                                                  topLeft: Radius.circular(4),
                                                  topRight: Radius.circular(4));
                                            } else if (index ==
                                                quantityDropdownItems.length -
                                                    1) {
                                              return const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(4),
                                                  bottomRight:
                                                      Radius.circular(4));
                                            }
                                            return BorderRadius.circular(0);
                                          }()),
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkResponse(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          highlightShape: BoxShape.rectangle,
                                          onTap: () {
                                            setState(() {
                                              selectedQuantity = "$item";
                                              isQuantitySelected =
                                                  !isQuantitySelected;
                                            });
                                            context.removeOverlay();
                                          },
                                          child: Center(child: Text("$item")),
                                        ),
                                      ));
                                }),
                          );
                        }),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            print("CLOSE");
            Navigator.pop(context);
          },
          child: const Text("Close"),
        ),
        ElevatedButton(
          onPressed: () {
            print("VALIDATE");
            Navigator.pop(context);
          },
          child: const Text("Add"),
        ),
      ],
    );
  }
}
