import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/course.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/regular_expressions.dart';

class CourseFormFields extends StatefulWidget {
  const CourseFormFields({
    super.key,
    this.isLoading = false,
    this.item,
    required this.onTapAffirm,
    required this.formKey,
    required this.controllers,
  });

  final bool isLoading;
  final void Function()? onTapAffirm;
  final GlobalKey<FormState> formKey;
  final Map<String, TextEditingController> controllers;
  final Course? item;

  @override
  State<CourseFormFields> createState() => _CourseDialogState();
}

class _CourseDialogState extends State<CourseFormFields> {
  bool isFrequencyFocused = false;
  late final List<String> frequencyDropdowItems = [
    "Hr",
    "Day",
    "Wk",
    "Mo",
    "Yr",
    "Ttl"
  ];
  late final focusNodes = {
    'name': FocusNode(),
    'cost': FocusNode(),
  };
  final courseKey = GlobalKey();
  late final layerLink = LayerLink();
  late ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics();

  @override
  void dispose() {
    for (FocusNode node in focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      widget.controllers['name']!.text = widget.item!.name;
      widget.controllers['cost']!.text = "${widget.item!.cost}";
      widget.controllers['name']!.text = widget.item!.costFrequency;
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
            physics: scrollPhysics,
            children: [
              Column(
                spacing: 18,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "* required fields",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                  const SizedBox(),

                  //Name Field
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: focusNodes['name']!,
                      controller: widget.controllers['name']!,
                      onTapOutside: (_) => focusNodes['name']!.unfocus(),
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

                  //Cost Field
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 180,
                        child: TextFormField(
                          keyboardType: const TextInputType.numberWithOptions(),
                          focusNode: focusNodes['cost']!,
                          controller: widget.controllers['cost']!,
                          onTapOutside: (_) => focusNodes['cost']!.unfocus(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter cost';
                            } else if (!RegularExpressions.numTwoDecimalsRegex
                                    .hasMatch(value) ||
                                RegularExpressions.leadingZerosRegex
                                    .hasMatch(value)) {
                              return 'Invalid cost';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            prefix: Text("\$"),
                            labelText: "Cost*",
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
                        controller: widget.controllers['frequency'],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid';
                          }
                          return null;
                        },
                        isFocused: isFrequencyFocused,
                        inkWellSize: const InkWellSize(height: 47, width: 66),
                        onTap: () {
                          isFrequencyFocused = !isFrequencyFocused;
                          scrollPhysics = const NeverScrollableScrollPhysics();
                          setState(() {});

                          context.insertOverlay(
                            widgetKey: courseKey,
                            context: context,
                            layerLink: layerLink,
                            onTapOutsideOverlay: () {
                              isFrequencyFocused = !isFrequencyFocused;
                              scrollPhysics =
                                  const AlwaysScrollableScrollPhysics();
                              setState(() {});
                              context.removeOverlay();
                            },
                            itemCount: frequencyDropdowItems.length,
                            itemBuilder: (context, index) {
                              String item = frequencyDropdowItems[index];

                              return DropDownItemTile(
                                currentIndex: index,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                itemFormat: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                ),
                                onTap: () {
                                  widget.controllers['frequency']!.text = item;
                                  isFrequencyFocused = !isFrequencyFocused;
                                  scrollPhysics =
                                      const AlwaysScrollableScrollPhysics();
                                  setState(() {});
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
