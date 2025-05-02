import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';
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
  final List<String> frequencyDropdowItems = ["Hr", "Day", "Wk", "Mo", "Yr"];
  final nameFocus = FocusNode();
  final costFocus = FocusNode();
  final quantityFocus = FocusNode();
  final numTwoDecimalsRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  final leadingZerosRegex = RegExp(r'^0+\d');
  final courseKey = GlobalKey();
  late final layerLink = LayerLink();

  @override
  void dispose() {
    nameFocus.dispose();
    costFocus.dispose();
    quantityFocus.dispose();
    super.dispose();
  }

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "* required fields",
                    style: TextStyle(color: Colors.grey.shade600),
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

                      //Frequency dropDown Menu
                      DropdownMenuTile(
                        widgetKey: courseKey,
                        layerLink: layerLink,
                        labelText: "Frequency*",
                        controller: widget.frequencyController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid';
                          }
                          return null;
                        },
                        isFocused: isFrequencySelected,
                        inkWellSize: const InkWellSize(height: 47, width: 66),
                        onTap: () {
                          setState(() {
                            isFrequencySelected = !isFrequencySelected;
                          });

                          context.insertOverlay(
                            widgetKey: courseKey,
                            context: context,
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

                              return DropDownItemTile(
                                currentIndex: index,
                                itemFormat: [Text(item)],
                                height: 50,
                                onTap: () {
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
