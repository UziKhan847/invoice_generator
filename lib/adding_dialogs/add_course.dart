import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/add_dialog_tile.dart';
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

  String selectedFrequency = 'Hr';
  String selectedQuantity = '1';
  bool isFrequencySelected = false;
  bool isQuantitySelected = false;
  List<String> frequencyDropdowItems = ["Hr", "Day", "Wk", "Mo", "Yr"];
  List<int> quantityDropdownItems =
      List<int>.generate(99, (int index) => index + 1, growable: false);
  late AppData provider;
  final nameFocus = FocusNode();
  final costFocus = FocusNode();
  final costRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  final costZeroRegex = RegExp(r'^0+\d');

  @override
  void dispose() {
    nameController.dispose();
    costController.dispose();
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

    return AddDialogTile(
      isLoading: isLoading,
      dialogTitle: "Add Course",
      onTapAdd: () async {
        if (_formKey.currentState!.validate()) {
          loadCircle();
          await provider.insertCourse(
            context: context,
            name: nameController.text,
            cost: double.parse(costController.text),
            frequency: selectedFrequency,
            quantity: int.parse(selectedQuantity),
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
      dialogContent: SizedBox(
        height: 148,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //  Margins.vertical4,

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
                    labelText: "Course Name",
                    errorStyle: TextStyle(height: 0, fontSize: 11),
                  ),
                ),
              ),
              Margins.vertical18,

              //Cost Field
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextFormField(
                      focusNode: costFocus,
                      controller: costController,
                      onTapOutside: (_) => costFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter cost';
                        } else if (!costRegex.hasMatch(value) ||
                            costZeroRegex.hasMatch(value)) {
                          return 'Invalid cost';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        prefix: Text("\$"),
                        labelText: "Cost (CAD)",
                        errorStyle: TextStyle(height: 0, fontSize: 11),
                      ),
                    ),
                  ),
                  Margins.horizontal14,

                  //Frequency DropDown Menu
                  DropdownMenuTile(
                    labelText: "Frequency",
                    selectedItem: selectedFrequency,
                    isSelected: isFrequencySelected,
                    arrowRightPosition: 2,
                    arrowTopPosition: 12,
                    menuInkHeight: 47,
                    menuInkWidth: 64,
                    menuBoxWidth: 64,
                    onTapMenuBox: () {
                      setState(() {
                        isFrequencySelected = !isFrequencySelected;
                      });

                      context.insertOverlay(
                        context,
                        height: 250,
                        width: 62,
                        bottom: 60,
                        right: 116,
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
                                lastItemIndex: frequencyDropdowItems.length - 1,
                                menuItemHeight: 50,
                                onItemTap: () {
                                  setState(() {
                                    selectedFrequency = item;
                                    isFrequencySelected = !isFrequencySelected;
                                  });
                                  context.removeOverlay();
                                },
                              );
                            }),
                      );
                    },
                  ),
                  Margins.horizontal14,

                  //Quantity DropDown Menu
                  DropdownMenuTile(
                    labelText: "Quantity",
                    selectedItem: selectedQuantity,
                    isSelected: isQuantitySelected,
                    arrowRightPosition: 2,
                    arrowTopPosition: 12,
                    menuInkHeight: 47,
                    menuInkWidth: 55,
                    menuBoxWidth: 55,
                    onTapMenuBox: () {
                      setState(() {
                        isQuantitySelected = !isQuantitySelected;
                      });

                      context.insertOverlay(
                        context,
                        height: 310,
                        width: 53,
                        bottom: 0,
                        right: 48,
                        onTapOutsideOverlay: () {
                          setState(() {
                            isQuantitySelected = !isQuantitySelected;
                          });
                          context.removeOverlay();
                        },
                        listViewBuilder: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: quantityDropdownItems.length,
                            itemBuilder: (context, index) {
                              String item = "${quantityDropdownItems[index]}";

                              return DropdownItemTile(
                                currentMenuIndex: index,
                                itemText: item,
                                lastItemIndex: quantityDropdownItems.length - 1,
                                menuItemHeight: 50,
                                onItemTap: () {
                                  setState(() {
                                    selectedQuantity = item;
                                    isQuantitySelected = !isQuantitySelected;
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
        ),
      ),
    );
  }
}
