import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/country.dart';
import 'package:markaz_umaza_invoice_generator/models/province.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddRecipient extends ConsumerStatefulWidget {
  const AddRecipient({super.key});

  @override
  ConsumerState<AddRecipient> createState() => _AddRecipientConsumerState();
}

class _AddRecipientConsumerState extends ConsumerState<AddRecipient> {
//  Form
  final _formKey = GlobalKey<FormState>();

// Layer Link
  late final layerLinks = {
    'country': LayerLink(),
    'prov': LayerLink(),
  };

// UI State
  bool isLoading = false;
  bool isProvFocused = false;
  bool isCountryFocused = false;

// Controllers
  final controllers = {
    'name': TextEditingController(),
    'street': TextEditingController(),
    'city': TextEditingController(),
    'country': TextEditingController(),
    'prov': TextEditingController(),
    'zip': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
  };

// Focus Nodes and Keys
  final focusNodes = {
    'name': FocusNode(),
    'street': FocusNode(),
    'city': FocusNode(),
    'zip': FocusNode(),
    'phone': FocusNode(),
    'email': FocusNode(),
  };

  final keys = {
    'country': GlobalKey(),
    'prov': GlobalKey(),
  };

// Dropdown Items
  // List<String> get provDropdownItems =>
  //     Countries.countries[controllers['country']!.text]!['provinces']
  //         as List<String>;

// Regex and Validation
  // RegExp get zipRegex => RegExp(Countries
  //     .countries[controllers['country']!.text]!['postal_code_regex'] as String);
  final emailRegex = RegExp(r'^.+@[0-z]+\.[A-z]+$');
  // RegExp get phoneRegex =>
  //     RegExp(Countries.countries[controllers['country']!.text]!['phone_regex']
  //         as String);

// External Data
  late AppData provider;

  int selectedCountryIndex = 0;

  late List<Country> countries = Countries.countries;

  String getProv(List<Province> prov, int index, String countryIsoTwo) {
    final currentProv = prov[index];
    final iso = currentProv.iso;

    if (iso == null) return currentProv.name;

    return int.tryParse(iso) == null ? iso : '$countryIsoTwo-$iso';
  }

  @override
  void dispose() {
    for (TextEditingController e in controllers.values) {
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
            name: controllers['name']!.text,
            street: controllers['street']!.text,
            city: controllers['city']!.text,
            prov: controllers['prov']!.text,
            country: controllers['country']!.text,
            zip: countries[selectedCountryIndex].postalCodeRegex == null
                ? null
                : controllers['zip']!.text,
            phone: controllers['phone']!.text,
            email: controllers['email']!.text,
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
                      focusNode: focusNodes['name']!,
                      controller: controllers['name']!,
                      onTapOutside: (_) => focusNodes['name']!.unfocus(),
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
                    widgetKey: keys['country']!,
                    layerLink: layerLinks['country']!,
                    controller: controllers['country']!,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Invalid';
                      }
                      return null;
                    },
                    labelText: "Country*",
                    labelTextSize: 12.5,
                    isFocused: isCountryFocused,
                    menuInkHeight: 47,
                    menuInkWidth: 150,
                    menuBoxWidth: 150,
                    onTapMenuBox: () {
                      setState(() {
                        isCountryFocused = !isCountryFocused;
                      });

                      context.insertOverlay(
                        context: context,
                        widgetKey: keys['country']!,
                        layerLink: layerLinks['country']!,
                        onTapOutsideOverlay: () {
                          setState(() {
                            isCountryFocused = !isCountryFocused;
                          });
                          context.removeOverlay();
                        },
                        itemCount: Countries.countries.length,
                        itemBuilder: (context, index) {
                          String item = Countries.countries[index].name;

                          return DropdownItemTile(
                            currentMenuIndex: index,
                            itemText: item,
                            menuItemHeight: 50,
                            onItemTap: () {
                              setState(() {
                                controllers['country']!.text = item;
                                selectedCountryIndex = index;
                                isCountryFocused = !isCountryFocused;
                              });
                              context.removeOverlay();
                            },
                          );
                        },
                      );
                    },
                  ),
                  Margins.vertical18,

                  //Street
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: focusNodes['street']!,
                      controller: controllers['street']!,
                      onTapOutside: (_) => focusNodes['street']!.unfocus(),
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
                          focusNode: focusNodes['city']!,
                          controller: controllers['city']!,
                          onTapOutside: (_) => focusNodes['city']!.unfocus(),
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

                      if (controllers['country']!.text.isNotEmpty) ...[
                        //Province DropDown Menu
                        DropdownMenuTile(
                          widgetKey: keys['prov']!,
                          layerLink: layerLinks['prov']!,
                          controller: controllers['prov']!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Invalid';
                            }
                            return null;
                          },
                          labelText: "Province*",
                          labelTextSize: 12.5,
                          isFocused: isProvFocused,
                          menuInkHeight: 47,
                          menuInkWidth: 68,
                          menuBoxWidth: 68,
                          onTapMenuBox: () {
                            setState(() {
                              isProvFocused = !isProvFocused;
                            });

                            context.insertOverlay(
                              context: context,
                              widgetKey: keys['prov']!,
                              layerLink: layerLinks['prov']!,
                              onTapOutsideOverlay: () {
                                setState(() {
                                  isProvFocused = !isProvFocused;
                                });
                                context.removeOverlay();
                              },
                              itemCount: Countries
                                  .countries[selectedCountryIndex]
                                  .provinces
                                  .length,
                              itemBuilder: (context, index) {
                                final country = countries[selectedCountryIndex];

                                String item = getProv(
                                  country.provinces,
                                  index,
                                  country.countryCode.isoTwo,
                                );

                                return DropdownItemTile(
                                  currentMenuIndex: index,
                                  itemText: item,
                                  menuItemHeight: 50,
                                  onItemTap: () {
                                    setState(() {
                                      controllers['prov']!.text = item;
                                      isProvFocused = !isProvFocused;
                                    });
                                    context.removeOverlay();
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                  Margins.vertical18,

                  if (controllers['country']!.text.isNotEmpty &&
                      Countries.countries[selectedCountryIndex]
                              .postalCodeRegex !=
                          null) ...[
                    //Zip
                    SizedBox(
                      width: 100,
                      height: 65,
                      child: TextFormField(
                        focusNode: focusNodes['zip']!,
                        controller: controllers['zip']!,
                        onTapOutside: (_) => focusNodes['zip']!.unfocus(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Zipcode';
                          } else if (!RegExp(Countries
                                  .countries[selectedCountryIndex]
                                  .postalCodeRegex!)
                              .hasMatch(value)) {
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
                  ],

                  if (controllers['country']!.text.isNotEmpty) ...[
                    //Phone
                    SizedBox(
                      height: 65,
                      child: TextFormField(
                        focusNode: focusNodes['phone']!,
                        controller: controllers['phone']!,
                        keyboardType: TextInputType.phone,
                        onTapOutside: (_) => focusNodes['phone']!.unfocus(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a Phone Number';
                          } else if (!RegExp(Countries
                                  .countries[selectedCountryIndex].phoneRegex)
                              .hasMatch(value)) {
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
                  ],

                  //Email
                  SizedBox(
                    height: 65,
                    child: TextFormField(
                      focusNode: focusNodes['email']!,
                      controller: controllers['email']!,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (_) => focusNodes['email']!.unfocus(),
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
