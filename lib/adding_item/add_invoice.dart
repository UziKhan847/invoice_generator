// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/datepickermenu/datepicker_menu.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_course_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/arrow_color.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/models/recipient.dart';
import 'package:markaz_umaza_invoice_generator/models/sender.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddInvoice extends ConsumerStatefulWidget {
  const AddInvoice({super.key});

  @override
  ConsumerState<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends ConsumerState<AddInvoice> {
// Form and Scroll
  final _formKey = GlobalKey<FormState>();
  late ScrollPhysics scrollPhysics = AlwaysScrollableScrollPhysics();

// Controllers
  late final Map<String, TextEditingController> controllers = {
    'date': TextEditingController(),
    'dueDate': TextEditingController(),
    'sender': TextEditingController(),
    'recipient': TextEditingController(),
  };
  final courseControllers =
      List<TextEditingController>.generate(5, (_) => TextEditingController());
  final quantityControllers =
      List<TextEditingController>.generate(5, (_) => TextEditingController());

// Focus and Keys
  final quantityFocusNodes = List<FocusNode>.generate(5, (_) => FocusNode());

  final keys = {
    'sender': GlobalKey(),
    'recipient': GlobalKey(),
  };
  final courseKeys = List<GlobalKey>.generate(5, (_) => GlobalKey());

  late final layerLinks = {
    'sender': LayerLink(),
    'recipient': LayerLink(),
  };
  late final courseLayerLinks = List<LayerLink>.generate(5, (_) => LayerLink());

// UI State
  bool isLoading = false;
  bool isSenderFocused = false;
  bool isRecipientSelected = false;
  List<bool> isEnabled = List<bool>.generate(5, (_) => true);
  List<bool> isCourseSFocused = List<bool>.generate(5, (_) => false);

// dropDown/Menu State
  late Sender selectedSender;
  late Recipient selectedRecipient;
  List<Course> courseMenuItems = [];
  Map<int, Course> selectedCourses = {};
  Map<int, double> courseQuantities = {};
  Map<int, double> courseAmounts = {};
  int numberOfCourses = 1;
  bool isCourseAdded = false;
  double coursesSubtotal = 0;

// Misc
  late AppData provider;
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();

    for (TextEditingController e in quantityControllers) {
      e.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    for (TextEditingController e in controllers.values) {
      e.dispose();
    }

    for (TextEditingController e in courseControllers) {
      e.dispose();
    }
    for (TextEditingController e in quantityControllers) {
      e.dispose();
    }
    super.dispose();
  }

  void loadCircle() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);
    int courseIndex = numberOfCourses - 1;

    if (courseMenuItems.isEmpty) {
      courseMenuItems = List.from(provider.courses);
    }

    if (numberOfCourses > 1 && isCourseAdded) {
      for (int i = 0; i < numberOfCourses; i++) {
        courseMenuItems.removeWhere((item) => item == selectedCourses[i]);
      }
      isCourseAdded = false;
    }

    return DialogTile(
      affirmButtonText: "Add",
      cancelButtonText: "Cancel",
      isLoading: isLoading,
      dialogHeight: 350,
      dialogTitle: "Add Invoice",
      onTapAffirm: () async {
        if (_formKey.currentState!.validate()) {
          loadCircle();

          selectedCourses.forEach((key, value) {
            courseQuantities[key] =
                double.tryParse(quantityControllers[key].text)!;

            courseAmounts[key] = value.cost * courseQuantities[key]!;

            coursesSubtotal = coursesSubtotal + courseAmounts[key]!;
          });

          await provider.insertInvoice(
              context: context,
              invoiceDate: controllers['date']!.text,
              dueDate: controllers['dueDate']!.text,
              senderId: selectedSender.senderId,
              recipientId: selectedRecipient.recipientId,
              selectedCourses: selectedCourses,
              quantities: courseQuantities,
              amounts: courseAmounts,
              subtotal: coursesSubtotal);
          loadCircle();

          if (context.mounted) {
            Navigator.pop(context);
          }
        }
      },
      onTapCancel: () {
        Navigator.pop(context);
      },
      dialogContent: Form(
        key: _formKey,
        child: SizedBox(
          width: 270,
          child: ListView(
            physics: scrollPhysics,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "* required fields\nauto - if left blank, autogenerated",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  Margins.vertical26,

                  //Invoice Date
                  SizedBox(
                    height: 65,
                    child: DatepickerMenu(
                      controller: controllers['date']!,
                      labelText: "Invoice Date (auto)",
                      isFocused: false,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020, 01, 01),
                          lastDate: DateTime(2100, 12, 31),
                        );

                        if (newDate == null) return;

                        setState(() {
                          controllers['date']!.text =
                              '${newDate.year}-${newDate.month}-${newDate.day}';
                        });
                      },
                      onTapDelete: () {
                        setState(() {
                          controllers['date']!.clear();
                        });
                      },
                    ),
                  ),
                  Margins.vertical14,

                  //Due Date
                  SizedBox(
                    height: 65,
                    child: DatepickerMenu(
                      controller: controllers['dueDate']!,
                      labelText: "Due Date",
                      isFocused: false,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020, 01, 01),
                          lastDate: DateTime(2100, 12, 31),
                        );

                        if (newDate == null) return;

                        setState(() {
                          controllers['dueDate']!.text =
                              '${newDate.year}-${newDate.month}-${newDate.day}';
                        });
                      },
                      onTapDelete: () {
                        setState(() {
                          controllers['dueDate']!.clear();
                        });
                      },
                    ),
                  ),
                  Margins.vertical14,

                  //Sender dropDown
                  DropdownMenuTile(
                    layerLink: layerLinks['sender']!,
                    controller: controllers['sender']!,
                    widgetKey: keys['sender'],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select Sender";
                      }
                      return null;
                    },
                    textPadding: EdgeInsets.only(
                        top: 12, bottom: 12, right: 22, left: 10),
                    labelText: "Sender*",
                    labelTextSize: 16,
                    isFocused: isSenderFocused,
                    onTap: () {
                      setState(() {
                        isSenderFocused = !isSenderFocused;
                        scrollPhysics = NeverScrollableScrollPhysics();
                      });

                      context.insertOverlay(
                        context: context,
                        widgetKey: keys['sender'],
                        layerLink: layerLinks['sender']!,
                        onTapOutsideOverlay: () {
                          setState(() {
                            isSenderFocused = !isSenderFocused;
                            scrollPhysics = AlwaysScrollableScrollPhysics();
                          });
                          context.removeOverlay();
                        },
                        itemCount: provider.senders.length,
                        itemBuilder: (context, index) {
                          Sender item = provider.senders[index];

                          return DropDownItemTile(
                            currentIndex: index,
                            itemFormat: [
                              Text(
                                  "#${item.senderId}- ${item.name}\n${item.street}, ${item.city}, ${item.province}\n${item.email},\n${item.eTransfer}")
                            ],
                            height: 100,
                            onTap: () {
                              selectedSender = item;
                              controllers['sender']!.text =
                                  "#${item.senderId}- ${item.name}, ${item.street}, ${item.city}, ${item.province}, ${item.email}, ${item.eTransfer}";
                              isSenderFocused = !isSenderFocused;

                              setState(() {});
                              context.removeOverlay();
                            },
                          );
                        },
                      );
                    },
                  ),
                  Margins.vertical18,

                  //Recipient dropDown
                  DropdownMenuTile(
                    layerLink: layerLinks['recipient']!,
                    controller: controllers['recipient']!,
                    key: keys['recipient'],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select Recipient";
                      }
                      return null;
                    },
                    textPadding: EdgeInsets.only(
                        top: 12, bottom: 12, right: 22, left: 10),
                    labelText: "Recipient*",
                    labelTextSize: 16,
                    isFocused: isRecipientSelected,
                    onTap: () {
                      setState(() {
                        isRecipientSelected = !isRecipientSelected;
                        scrollPhysics = NeverScrollableScrollPhysics();
                      });

                      context.insertOverlay(
                        context: context,
                        widgetKey: keys['recipient']!,
                        layerLink: layerLinks['recipient']!,
                        onTapOutsideOverlay: () {
                          setState(() {
                            isRecipientSelected = !isRecipientSelected;
                            scrollPhysics = AlwaysScrollableScrollPhysics();
                          });
                          context.removeOverlay();
                        },
                        itemCount: provider.recipients.length,
                        itemBuilder: (context, index) {
                          Recipient item = provider.recipients[index];

                          return DropDownItemTile(
                            mainAxisAlignment: MainAxisAlignment.start,
                            currentIndex: index,
                            itemFormat: [
                              Text(
                                  "#${item.recipientId}- ${item.name}\n${item.street}\n${item.city}, ${item.province}\n${item.email}")
                            ],
                            height: 90,
                            onTap: () {
                              selectedRecipient = item;
                              controllers['recipient']!.text =
                                  "#${item.recipientId}- ${item.name}, ${item.street}, ${item.city}, ${item.province}, ${item.email}";
                              isRecipientSelected = !isRecipientSelected;

                              setState(() {});
                              context.removeOverlay();
                            },
                          );
                        },
                      );
                    },
                  ),
                  Margins.vertical18,

                  //Courses
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Courses (Upto 5):"),
                      Row(
                        children: [
                          IconButton(
                            style: const ButtonStyle(
                                iconSize: WidgetStatePropertyAll(20),
                                shape: WidgetStatePropertyAll(CircleBorder()),
                                overlayColor:
                                    WidgetStatePropertyAll(Color(0xFFD7FFD8))),
                            onPressed: selectedCourses[courseIndex] == null ||
                                    quantityControllers[courseIndex]
                                        .text
                                        .isEmpty ||
                                    numberOfCourses == 5
                                ? null
                                : () {
                                    isCourseAdded = true;
                                    numberOfCourses++;
                                    isEnabled[courseIndex] = false;
                                    setState(() {});
                                  },
                            icon: const Icon(Icons.add),
                          ),
                          IconButton(
                            style: const ButtonStyle(
                                iconSize: WidgetStatePropertyAll(20),
                                shape: WidgetStatePropertyAll(CircleBorder()),
                                overlayColor:
                                    WidgetStatePropertyAll(Color(0xFFFFD7D7))),
                            onPressed: numberOfCourses == 1
                                ? null
                                : () {
                                    courseControllers[courseIndex].clear();
                                    quantityControllers[courseIndex].clear();

                                    courseMenuItems
                                        .add(selectedCourses[courseIndex - 1]!);

                                    courseMenuItems.sort((a, b) =>
                                        a.courseId.compareTo(b.courseId));

                                    selectedCourses.remove(courseIndex);

                                    isEnabled[courseIndex - 1] = true;
                                    numberOfCourses--;
                                    setState(() {});
                                  },
                            icon: const Icon(Icons.remove),
                          )
                        ],
                      )
                    ],
                  ),

                  for (int i = 0; i < numberOfCourses; i++) ...[
                    DropDownCourseTile(
                      layerLink: courseLayerLinks[i],
                      widgetKey: courseKeys[i],
                      textStyle: numberOfCourses == i + 1
                          ? null
                          : TextStyle(color: Colors.grey.shade500),
                      arrowColor: ArrowColor(
                        dropDown: numberOfCourses == i + 1
                            ? null
                            : Colors.grey.shade500,
                      ),
                      isFocused: isCourseSFocused[i],
                      courseNumber: i + 1,
                      courseController: courseControllers[i],
                      quantityController: quantityControllers[i],
                      quantityFocus: quantityFocusNodes[i],
                      isEnabled: isEnabled[i],
                      onTap: numberOfCourses != i + 1
                          ? null
                          : () {
                              setState(() {
                                isCourseSFocused[i] = !isCourseSFocused[i];
                                scrollPhysics = NeverScrollableScrollPhysics();
                              });

                              context.insertOverlay(
                                context: context,
                                layerLink: courseLayerLinks[i],
                                widgetKey: courseKeys[i],
                                onTapOutsideOverlay: () {
                                  setState(() {
                                    isCourseSFocused[i] = !isCourseSFocused[i];
                                    scrollPhysics =
                                        AlwaysScrollableScrollPhysics();
                                  });
                                  context.removeOverlay();
                                },
                                itemCount: courseMenuItems.length,
                                itemBuilder: (context, index) {
                                  Course item = courseMenuItems[index];

                                  return DropDownItemTile(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    currentIndex: index,
                                    itemFormat: [
                                      Text(
                                          "#${item.courseId}- ${item.name}\n\$${item.cost}/${item.costFrequency}")
                                    ],
                                    height: 75,
                                    onTap: () {
                                      selectedCourses[i] = item;

                                      courseControllers[i].text =
                                          "#${item.courseId}- ${item.name}, \$${item.cost}/${item.costFrequency}";

                                      isCourseSFocused[i] =
                                          !isCourseSFocused[i];

                                      setState(() {});
                                      context.removeOverlay();
                                    },
                                  );
                                },
                              );
                            },
                    ),
                    if (i != 4) ...[Margins.vertical10]
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
