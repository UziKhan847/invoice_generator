// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/datepickermenu/datepicker_menu.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_course_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
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
  ConsumerState<AddInvoice> createState() => _AddInvoiceConsumerState();
}

class _AddInvoiceConsumerState extends ConsumerState<AddInvoice> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final dateController = TextEditingController();
  final dueDateController = TextEditingController();
  final senderController = TextEditingController();
  final recipientController = TextEditingController();
  final List<TextEditingController> courseControllers =
      List<TextEditingController>.generate(5, (_) => TextEditingController());
  final List<TextEditingController> quantityControllers =
      List<TextEditingController>.generate(5, (_) => TextEditingController());
  final List<FocusNode> quantityFocusNodes =
      List<FocusNode>.generate(5, (_) => FocusNode());

  bool isSenderSelected = false;
  bool isRecipientSelected = false;

  List<bool> isCourseSelected = List<bool>.generate(5, (_) => false);
  List<Course> courseMenuItems = [];

  late Sender selectedSender;
  late Recipient selectedRecipient;
  Map<int, Course> selectedCourses = {};
  double coursesSubtotal = 0;
  Map<int, double> courseQuantities = {};
  Map<int, double> courseAmounts = {};
  int numberOfCourses = 1;
  bool isCourseAdded = false;

  double shadowHeight = 0;
  double menuHeight = 0;

  late AppData provider;
  DateTime now = DateTime.now();

  @override
  void dispose() {
    dateController.dispose();
    dueDateController.dispose();
    senderController.dispose();
    recipientController.dispose();
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
              invoiceDate: dateController.text,
              dueDate: dueDateController.text,
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
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "* required fields\nauto - if left blank, autogenerated",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Margins.vertical26,

                  //Invoice Date
                  SizedBox(
                    height: 65,
                    child: DatepickerMenu(
                      controller: dateController,
                      labelText: "Invoice Date (auto)",
                      isSelected: false,
                      menuInkHeight: 46,
                      menuInkWidth: 155,
                      menuBoxWidth: 155,
                      iconRightPosition: 8,
                      iconTopPosition: 10,
                      onTapMenuBox: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2000, 01, 01),
                          lastDate: DateTime(2100, 12, 31),
                        );

                        if (newDate == null) return;

                        setState(() {
                          dateController.text =
                              '${newDate.year}-${newDate.month}-${newDate.day}';
                        });
                      },
                      onTapDelete: () {
                        setState(() {
                          dateController.clear();
                        });
                      },
                    ),
                  ),
                  Margins.vertical14,

                  //Due Date
                  SizedBox(
                    height: 65,
                    child: DatepickerMenu(
                      controller: dueDateController,
                      labelText: "Due Date",
                      isSelected: false,
                      menuInkHeight: 46,
                      menuInkWidth: 155,
                      menuBoxWidth: 155,
                      iconRightPosition: 8,
                      iconTopPosition: 10,
                      onTapMenuBox: () async {
                        DateTime? newDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100, 12, 31),
                        );

                        if (newDate == null) return;

                        setState(() {
                          dueDateController.text =
                              '${newDate.year}-${newDate.month}-${newDate.day}';
                        });
                      },
                      onTapDelete: () {
                        setState(() {
                          dueDateController.clear();
                        });
                      },
                    ),
                  ),
                  Margins.vertical14,

                  //Sender DropDown
                  DropdownMenuTile(
                    controller: senderController,
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
                    isSelected: isSenderSelected,
                    arrowRightPosition: 2,
                    arrowTopPosition: 12,
                    menuInkHeight: 47,
                    onTapMenuBox: () {
                      setState(() {
                        isSenderSelected = !isSenderSelected;
                      });

                      context.insertOverlay(
                        context,
                        height: 200,
                        width: 260,
                        bottom: 200,
                        right: 50,
                        onTapOutsideOverlay: () {
                          setState(() {
                            isSenderSelected = !isSenderSelected;
                          });
                          context.removeOverlay();
                        },
                        listViewBuilder: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: provider.senders.length,
                            itemBuilder: (context, index) {
                              Sender item = provider.senders[index];

                              return DropdownItemTile(
                                currentMenuIndex: index,
                                itemText:
                                    "#${item.senderId}- ${item.name}\n${item.street}, ${item.city}, ${item.province}\n${item.email},\n${item.eTransfer}",
                                lastItemIndex: provider.senders.length - 1,
                                menuItemHeight: 100,
                                onItemTap: () {
                                  selectedSender = item;
                                  senderController.text =
                                      "#${item.senderId}- ${item.name}, ${item.street}, ${item.city}, ${item.province}, ${item.email}, ${item.eTransfer}";
                                  isSenderSelected = !isSenderSelected;

                                  setState(() {});
                                  context.removeOverlay();
                                },
                              );
                            }),
                      );
                    },
                  ),
                  Margins.vertical18,

                  //Recipient DropDown
                  DropdownMenuTile(
                    controller: recipientController,
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
                    isSelected: isRecipientSelected,
                    arrowRightPosition: 2,
                    arrowTopPosition: 12,
                    menuInkHeight: 47,
                    onTapMenuBox: () {
                      setState(() {
                        isRecipientSelected = !isRecipientSelected;
                      });

                      context.insertOverlay(
                        context,
                        height: 500,
                        width: 260,
                        bottom: 0,
                        right: 50,
                        onTapOutsideOverlay: () {
                          setState(() {
                            isRecipientSelected = !isRecipientSelected;
                          });
                          context.removeOverlay();
                        },
                        listViewBuilder: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: provider.recipients.length,
                            itemBuilder: (context, index) {
                              Recipient item = provider.recipients[index];

                              return DropdownItemTile(
                                mainAxisAlignment: MainAxisAlignment.start,
                                currentMenuIndex: index,
                                itemText:
                                    "#${item.recipientId}- ${item.name}\n${item.street}\n${item.city}, ${item.province}\n${item.email}",
                                lastItemIndex: provider.recipients.length - 1,
                                menuItemHeight: 90,
                                onItemTap: () {
                                  selectedRecipient = item;
                                  recipientController.text =
                                      "#${item.recipientId}- ${item.name}, ${item.street}, ${item.city}, ${item.province}, ${item.email}";
                                  isRecipientSelected = !isRecipientSelected;

                                  setState(() {});
                                  context.removeOverlay();
                                },
                              );
                            }),
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
                    DropdownCourseTile(
                      textStyle: numberOfCourses == i + 1
                          ? null
                          : TextStyle(color: Colors.grey.shade500),
                      arrowDownColor: numberOfCourses == i + 1
                          ? null
                          : Colors.grey.shade500,
                      isFirstCourse: i == 0,
                      isLastCourse: i == 4,
                      isSelected: isCourseSelected[i],
                      courseNumber: i + 1,
                      courseController: courseControllers[i],
                      quantityController: quantityControllers[i],
                      quantityFocus: quantityFocusNodes[i],
                      onTapMenuBox: numberOfCourses != i + 1
                          ? null
                          : () {
                              setState(() {
                                isCourseSelected[i] = !isCourseSelected[i];
                              });

                              context.insertOverlay(
                                context,
                                height: 450,
                                width: 260,
                                bottom: 100,
                                right: 50,
                                onTapOutsideOverlay: () {
                                  setState(() {
                                    isCourseSelected[i] = !isCourseSelected[i];
                                  });
                                  context.removeOverlay();
                                },
                                listViewBuilder: ListView.builder(
                                    padding: const EdgeInsets.all(0),
                                    itemCount: courseMenuItems.length,
                                    itemBuilder: (context, index) {
                                      Course item = courseMenuItems[index];

                                      return DropdownItemTile(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        currentMenuIndex: index,
                                        itemText:
                                            "#${item.courseId}- ${item.name}\n\$${item.cost}/${item.costFrequency}",
                                        lastItemIndex:
                                            courseMenuItems.length - 1,
                                        menuItemHeight: 75,
                                        onItemTap: () {
                                          selectedCourses[i] = item;

                                          courseControllers[i].text =
                                              "#${item.courseId}- ${item.name}, \$${item.cost}/${item.costFrequency}";

                                          isCourseSelected[i] =
                                              !isCourseSelected[i];

                                          setState(() {});
                                          context.removeOverlay();
                                        },
                                      );
                                    }),
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
