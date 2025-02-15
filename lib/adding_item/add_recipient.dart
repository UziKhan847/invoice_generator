import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddRecipient extends ConsumerStatefulWidget {
  const AddRecipient({super.key});

  @override
  ConsumerState<AddRecipient> createState() => _AddRecipientConsumerState();
}

class _AddRecipientConsumerState extends ConsumerState<AddRecipient> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final nameController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final countryController = TextEditingController()..text = 'Canada';
  final provController = TextEditingController();
  final zipController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  bool isProvSelected = false;
  bool isCountrySelected = false;

  final Map<String, List<String>> provStateMap = {
    'Canada': [
      "AB", // Alberta
      "BC", // British Columbia
      "MB", // Manitoba
      "NB", // New Brunswick
      "NL", // Newfoundland and Labrador
      "NS", // Nova Scotia
      "NT", // Northwest Territories
      "NU", // Nunavut
      "ON", // Ontario
      "PE", // Prince Edward Island
      "QC", // Quebec
      "SK", // Saskatchewan
      "YT" // Yukon
    ],
    'USA': [
      "AL", // Alabama
      "AK", // Alaska
      "AZ", // Arizona
      "AR", // Arkansas
      "CA", // California
      "CO", // Colorado
      "CT", // Connecticut
      "DE", // Delaware
      "FL", // Florida
      "GA", // Georgia
      "HI", // Hawaii
      "ID", // Idaho
      "IL", // Illinois
      "IN", // Indiana
      "IA", // Iowa
      "KS", // Kansas
      "KY", // Kentucky
      "LA", // Louisiana
      "ME", // Maine
      "MD", // Maryland
      "MA", // Massachusetts
      "MI", // Michigan
      "MN", // Minnesota
      "MS", // Mississippi
      "MO", // Missouri
      "MT", // Montana
      "NE", // Nebraska
      "NV", // Nevada
      "NH", // New Hampshire
      "NJ", // New Jersey
      "NM", // New Mexico
      "NY", // New York
      "NC", // North Carolina
      "ND", // North Dakota
      "OH", // Ohio
      "OK", // Oklahoma
      "OR", // Oregon
      "PA", // Pennsylvania
      "RI", // Rhode Island
      "SC", // South Carolina
      "SD", // South Dakota
      "TN", // Tennessee
      "TX", // Texas
      "UT", // Utah
      "VT", // Vermont
      "VA", // Virginia
      "WA", // Washington
      "WV", // West Virginia
      "WI", // Wisconsin
      "WY" // Wyoming
    ],
  };

  List<String> get provDropdowItems => provStateMap[countryController.text]!;

  List<String> countryDropdowItems = ["Canada", "USA"];
  late AppData provider;
  final nameFocus = FocusNode();
  final streetFocus = FocusNode();
  final cityFocus = FocusNode();
  final zipFocus = FocusNode();
  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();

  final Map<String, String> zipMapRegex = {
    'Canada': r'^\w\d\w\s?\d\w\d$',
    'USA': r'^\d{5}$',
  };

  RegExp get zipRegex => RegExp(zipMapRegex[countryController.text]!);

  final emailRegex = RegExp(r'^.+@[0-z]+\.[A-z]+$');
  final phoneRegex =
      RegExp(r'^\+?1?\s?(\(\d{3}\)|\d{3})(-|\s)?\d{3}(-|\s)?\d{4}$');

  String get zipWithSpace => switch (zipController.text.length) {
        6 =>
          '${zipController.text.substring(0, 3)} ${zipController.text.substring(3, 6)}'
              .toUpperCase(),
        _ => zipController.text.toUpperCase()
      };

  @override
  void dispose() {
    nameController.dispose();
    streetController.dispose();
    cityController.dispose();
    countryController.dispose();
    provController.dispose();
    zipController.dispose();
    phoneController.dispose();
    emailController.dispose();
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
      dialogTitle: "Add Recipeint",
      onTapAffirm: () async {
        if (_formKey.currentState!.validate()) {
          loadCircle();
          await provider.insertRecipeint(
            context: context,
            name: nameController.text,
            street: streetController.text,
            city: cityController.text,
            prov: provController.text,
            zip: zipWithSpace,
            phone: phoneController.text,
            email: emailController.text,
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
                        labelText: "Recipient/Company Name*",
                      ),
                    ),
                  ),
                  Margins.vertical18,

                  //Country DropDown Menu
                  DropdownMenuTile(
                    controller: countryController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid';
                      }
                      return null;
                    },
                    labelText: "Country*",
                    labelTextSize: 12.5,
                    isSelected: isCountrySelected,
                    menuInkHeight: 47,
                    menuInkWidth: 150,
                    menuBoxWidth: 150,
                    onTapMenuBox: () {
                      setState(() {
                        isCountrySelected = !isCountrySelected;
                      });

                      context.insertOverlay(
                        context,
                        height: 100,
                        width: 150,
                        bottom: 400,
                        right: 40,
                        onTapOutsideOverlay: () {
                          setState(() {
                            isCountrySelected = !isCountrySelected;
                          });
                          context.removeOverlay();
                        },
                        listViewBuilder: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              String item = countryDropdowItems[index];

                              return DropdownItemTile(
                                currentMenuIndex: index,
                                itemText: item,
                                lastItemIndex: countryDropdowItems.length - 1,
                                menuItemHeight: 50,
                                onItemTap: () {
                                  setState(() {
                                    countryController.text = item;
                                    isCountrySelected = !isCountrySelected;
                                  });
                                  context.removeOverlay();
                                },
                              );
                            }),
                      );
                    },
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
                            bottom: 50,
                            right: 140,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
