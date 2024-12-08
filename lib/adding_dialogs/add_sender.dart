import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddSender extends ConsumerStatefulWidget {
  const AddSender({super.key});

  @override
  ConsumerState<AddSender> createState() => _AddSenderState();
}

class _AddSenderState extends ConsumerState<AddSender> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final nameController = TextEditingController();
  final bnController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final provController = TextEditingController();
  final zipController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final eTransferController = TextEditingController();

  String selectedProv = 'ON';
  bool isProvSelected = false;
  List<String> provDropdowItems = [
    "AB",
    "BC",
    "MB",
    "NB",
    "NL",
    "NS",
    "NT",
    "NU",
    "ON",
    "PE",
    "QC",
    "SK",
    "YT"
  ];
  late AppData provider;
  final nameFocus = FocusNode();
  final bnFocus = FocusNode();
  final streetFocus = FocusNode();
  final cityFocus = FocusNode();
  final zipFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final eTransferFocus = FocusNode();
  final zipRegex = RegExp(r'^\w\d\w\s?\d\w\d$');
  final emailRegex = RegExp(r'^.+@[0-z]+\.[A-z]+$');
  final phoneRegex =
      RegExp(r'^\+?1?\s?(\(\d{3}\)|\d{3})(-|\s)?\d{3}(-|\s)?\d{4}$');
  final bnRegex = RegExp(r'^\d{9}\s?[A-z]{2}\s?\d{4}$');

  String get zipWithSpace => switch (zipController.text.length) {
        6 =>
          '${zipController.text.substring(0, 3)} ${zipController.text.substring(3, 6)}'
              .toUpperCase(),
        _ => zipController.text.toUpperCase()
      };

  String get bnFormat {
    String bnText =
        bnController.text.replaceAll(RegExp(r'\s'), '').toUpperCase();

    return '${bnText.substring(0, 9)} ${bnText.substring(9, 11)} ${bnText.substring(11, 15)}';
  }

  @override
  void dispose() {
    nameController.dispose();
    bnController.dispose();
    streetController.dispose();
    cityController.dispose();
    provController.dispose();
    zipController.dispose();
    phoneController.dispose();
    emailController.dispose();
    eTransferController.dispose();
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
      dialogHeight: 250,
      dialogTitle: "Add Sender",
      onTapAffirm: () async {
        if (_formKey.currentState!.validate()) {
          loadCircle();
          await provider.insertSender(
              context: context,
              name: nameController.text,
              businessNumber: bnFormat,
              street: streetController.text,
              city: cityController.text,
              prov: provController.text,
              zip: zipWithSpace,
              phone: phoneController.text,
              email: emailController.text,
              eTransfer: eTransferController.text);
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
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Sender Name*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  //BN Field
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: bnFocus,
                      controller: bnController,
                      onTapOutside: (_) => bnFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Business Number';
                        } else if (value.length < 15) {
                          return 'Min. is 15 characters w/o spaces';
                        } else if (value.length > 17) {
                          return 'Max. is 17 characters with spaces';
                        } else if (!bnRegex.hasMatch(value)) {
                          return "Invalid Business Number";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Business Number*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  //Street
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: streetFocus,
                      controller: streetController,
                      onTapOutside: (_) => streetFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the street';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Street (#, Name, etc.)*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //City
                      SizedBox(
                        height: 65,
                        width: 190,
                        child: TextFormField(
                          focusNode: cityFocus,
                          controller: cityController,
                          onTapOutside: (_) => cityFocus.unfocus(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter City name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: "City*",
                          ),
                        ),
                      ),

                      //Province DropDown Menu
                      DropdownMenuTile(
                        controller: provController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Invalid';
                          }
                          return null;
                        },
                        labelText: "Province*",
                        labelTextSize: 12.5,
                        isSelected: isProvSelected,
                        menuInkHeight: 47,
                        menuInkWidth: 68,
                        menuBoxWidth: 68,
                        onTapMenuBox: () {
                          setState(() {
                            isProvSelected = !isProvSelected;
                          });

                          context.insertOverlay(
                            context,
                            height: 650,
                            width: 66,
                            bottom: 0,
                            right: 46,
                            onTapOutsideOverlay: () {
                              setState(() {
                                isProvSelected = !isProvSelected;
                              });
                              context.removeOverlay();
                            },
                            listViewBuilder: ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: provDropdowItems.length,
                                itemBuilder: (context, index) {
                                  String item = provDropdowItems[index];

                                  return DropdownItemTile(
                                    currentMenuIndex: index,
                                    itemText: item,
                                    lastItemIndex: provDropdowItems.length - 1,
                                    menuItemHeight: 50,
                                    onItemTap: () {
                                      setState(() {
                                        provController.text = item;
                                        isProvSelected = !isProvSelected;
                                      });
                                      context.removeOverlay();
                                    },
                                  );
                                }),
                          );
                        },
                      ),
                    ],
                  ),
                  Margins.vertical18,

                  //Zip
                  SizedBox(
                    width: 100,
                    height: 65,
                    child: TextFormField(
                      focusNode: zipFocus,
                      controller: zipController,
                      onTapOutside: (_) => zipFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter Zipcode';
                        } else if (!zipRegex.hasMatch(value)) {
                          return 'Invalid Zip';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Zipcode*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  //Phone
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: phoneFocus,
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      onTapOutside: (_) => phoneFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a Phone Number';
                        } else if (!phoneRegex.hasMatch(value)) {
                          return 'Please enter a valid Phone Number';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Phone Number*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  //Email
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: emailFocus,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (_) => emailFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an Email';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Email*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  //Etransfer
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: eTransferFocus,
                      controller: eTransferController,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (_) => eTransferFocus.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Etransfer email';
                        } else if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Etransfer Email*",
                      ),
                    ),
                  ),
                  Margins.vertical18,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
