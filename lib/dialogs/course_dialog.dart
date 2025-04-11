import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class CourseDialog extends StatefulWidget {
  const CourseDialog({
    super.key,
    this.isLoading = false,
    this.item,
    required this.onTapAffirm,
    required this.formKey,
    required this.costController,
    required this.frequencyController,
    required this.nameController,
  });

  final bool isLoading;
  final void Function()? onTapAffirm;
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController costController;
  final TextEditingController frequencyController;
  final Course? item;

  @override
  State<CourseDialog> createState() => _CourseDialogState();
}

class _CourseDialogState extends State<CourseDialog> {
  bool isFrequencySelected = false;
  List<String> frequencyDropdowItems = ["Hr", "Day", "Wk", "Mo", "Yr"];
  final nameFocus = FocusNode();
  final costFocus = FocusNode();
  final quantityFocus = FocusNode();
  final numTwoDecimalsRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  final leadingZerosRegex = RegExp(r'^0+\d');
  late final layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      widget.nameController.text = widget.item!.name;
      widget.costController.text = "${widget.item!.cost}";
      widget.frequencyController.text = widget.item!.costFrequency;
    }

    return DialogTile(
      affirmButtonText: "Add",
      cancelButtonText: "Cancel",
      isLoading: widget.isLoading,
      dialogHeight: 200,
      dialogTitle: "Add Course",
      onTapAffirm: widget.onTapAffirm,
      onTapCancel: () {
        Navigator.pop(context);
      },
      dialogContent: Form(
        key: widget.formKey,
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
                      controller: widget.nameController,
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
                          controller: widget.costController,
                          onTapOutside: (_) => costFocus.unfocus(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter cost';
                            } else if (!numTwoDecimalsRegex.hasMatch(value) ||
                                leadingZerosRegex.hasMatch(value)) {
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

                      const Text(
                        "/",
                        style:
                            TextStyle(fontSize: 35, color: Color(0xFF868686)),
                      ),

                      //Frequency DropDown Menu
                      DropdownMenuTile(
                        layerLink: layerLink,
                        labelText: "Frequency*",
                        controller: widget.frequencyController,
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
                            layerLink: layerLink,
                      
               
                            onTapOutsideOverlay: () {
                              setState(() {
                                isFrequencySelected = !isFrequencySelected;
                              });
                              context.removeOverlay();
                            },
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
                                    widget.frequencyController.text = item;
                                    isFrequencySelected = !isFrequencySelected;
                                  });
                                  context.removeOverlay();
                                },
                              );
                            },
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
