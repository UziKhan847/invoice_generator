import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddCourse extends ConsumerStatefulWidget {
  const AddCourse({super.key});

  @override
  ConsumerState<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends ConsumerState<AddCourse> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final nameController = TextEditingController();
  final costController = TextEditingController();
  final frequencyController = TextEditingController();

  bool isFrequencySelected = false;
  List<String> frequencyDropdowItems = ["Hr", "Day", "Wk", "Mo", "Yr"];
  late AppData provider;
  final nameFocus = FocusNode();
  final costFocus = FocusNode();
  final quantityFocus = FocusNode();
  final moneyRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  final moneyZeroRegex = RegExp(r'^0+\d');

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
    frequencyController.dispose();
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

    return DialogTile(
      affirmButtonText: "Add",
      cancelButtonText: "Cancel",
      isLoading: isLoading,
      dialogHeight: 200,
      dialogTitle: "Add Course",
      onTapAffirm: () async {
        if (_formKey.currentState!.validate()) {
          loadCircle();
          await provider.insertCourse(
            context: context,
            name: nameController.text,
            cost: double.parse(costController.text),
            frequency: frequencyController.text,
            // quantity: double.parse(quantityController.text),
          );
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
          width: 290,
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "* required fields",
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  Margins.vertical26,

                  //Name Field
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: nameFocus,
                      controller: nameController,
                      onTapOutside: (_) => nameFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        } else if (value.length < 3) {
                          return 'Name must contain more than 3 characters';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Course Name*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  //Cost Field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(),
                          focusNode: costFocus,
                          controller: costController,
                          onTapOutside: (_) => costFocus.unfocus(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter cost';
                            } else if (!moneyRegex.hasMatch(value) ||
                                moneyZeroRegex.hasMatch(value)) {
                              return 'Invalid cost';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefix: Text("\$"),
                            labelText: "Cost (CAD)*",
                          ),
                        ),
                      ),

                      Text(
                        "/",
                        style: TextStyle(
                            fontSize: 35, color: const Color(0xFF868686)),
                      ),

                      //Frequency DropDown Menu
                      DropdownMenuTile(
                        labelText: "Frequency*",
                        controller: frequencyController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid';
                          }
                          return null;
                        },
                        isSelected: isFrequencySelected,
                        menuInkHeight: 47,
                        menuInkWidth: 66,
                        menuBoxWidth: 66,
                        onTapMenuBox: () {
                          setState(() {
                            isFrequencySelected = !isFrequencySelected;
                          });

                          context.insertOverlay(
                            context,
                            height: 250,
                            width: 64,
                            bottom: 42,
                            right: 117,
                            onTapOutsideOverlay: () {
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

                                  return DropdownItemTile(
                                    currentMenuIndex: index,
                                    itemText: item,
                                    lastItemIndex:
                                        frequencyDropdowItems.length - 1,
                                    menuItemHeight: 50,
                                    onItemTap: () {
                                      setState(() {
                                        frequencyController.text = item;
                                        isFrequencySelected =
                                            !isFrequencySelected;
                                      });
                                      context.removeOverlay();
                                    },
                                  );
                                }),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
