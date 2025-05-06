import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/extensions/string_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/country.dart';
import 'package:markaz_umaza_invoice_generator/models/province.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/utils/margins.dart';

class AddRecipient extends ConsumerStatefulWidget {
  const AddRecipient({super.key});

  @override
  ConsumerState<AddRecipient> createState() => _AddRecipientState();
}

class _AddRecipientState extends ConsumerState<AddRecipient> {
//  Form % Scroll
  final _formKey = GlobalKey<FormState>();
  late ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics();

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

  final emailRegex = RegExp(r'^.+@[0-z]+\.[A-z]+$');

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
            country: controllers['country']!.text.countryName,
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
                  Margins.vertical8,

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

                  //Country dropDown Menu
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
                    isFocused: isCountryFocused,
                    //inkWellSize: const InkWellSize(width: 150),
                    onTap: () {
                      isCountryFocused = !isCountryFocused;
                      scrollPhysics = const NeverScrollableScrollPhysics();
                      setState(() {});

                      context.insertOverlay(
                        context: context,
                        widgetKey: keys['country']!,
                        layerLink: layerLinks['country']!,
                        onTapOutsideOverlay: () {
                          isCountryFocused = !isCountryFocused;
                          scrollPhysics = const AlwaysScrollableScrollPhysics();
                          setState(() {});
                          context.removeOverlay();
                        },
                        itemCount: Countries.countries.length,
                        itemBuilder: (context, index) {
                          String countryName = Countries.countries[index].name;
                          String countryFlag =
                              Countries.countries[index].flagIcon;
                          String item = "$countryFlag - $countryName";

                          return DropDownItemTile(
                            currentIndex: index,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            itemFormat: Text(
                              item,
                              textAlign: TextAlign.center,
                            ),
                            onTap: () {
                              controllers['country']!.text = item;
                              selectedCountryIndex = index;
                              isCountryFocused = !isCountryFocused;
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

                  if (controllers['country']!.text.isNotEmpty) ...[
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

                        //Province dropDown Menu
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
                          inkWellSize: const InkWellSize(width: 68),
                          onTap: () {
                            isProvFocused = !isProvFocused;
                            scrollPhysics =
                                const NeverScrollableScrollPhysics();
                            setState(() {});

                            context.insertOverlay(
                              context: context,
                              widgetKey: keys['prov']!,
                              layerLink: layerLinks['prov']!,
                              onTapOutsideOverlay: () {
                                isProvFocused = !isProvFocused;
                                scrollPhysics =
                                    const AlwaysScrollableScrollPhysics();
                                setState(() {});
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

                                return DropDownItemTile(
                                  currentIndex: index,
                                  itemFormat: Text(item),
                                  height: 50,
                                  onTap: () {
                                    controllers['prov']!.text = item;
                                    isProvFocused = !isProvFocused;
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
                    ),

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

                    // if (Countries
                    //         .countries[selectedCountryIndex].postalCodeRegex !=
                    //     null)
                    //Zip
                    SizedBox(
                      width: 100,
                      height: 65,
                      child: TextFormField(
                        focusNode: focusNodes['zip']!,
                        controller: controllers['zip']!,
                        onTapOutside: (_) => focusNodes['zip']!.unfocus(),
                        validator: (value) {
                          if (Countries.countries[selectedCountryIndex]
                                  .postalCodeRegex !=
                              null) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Zipcode';
                            } else if (!RegExp(Countries
                                    .countries[selectedCountryIndex]
                                    .postalCodeRegex!)
                                .hasMatch(value)) {
                              return 'Invalid Zip';
                            }
                          }

                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Zipcode*",
                        ),
                      ),
                    ),

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
                          } else if (Countries
                                  .countries[selectedCountryIndex].phoneRegex !=
                              null) {
                            if (!RegExp(Countries
                                    .countries[selectedCountryIndex].phoneRegex!)
                                .hasMatch(value)) {
                              return 'Please enter a valid Phone Number';
                            }
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: "Phone Number*",
                        ),
                      ),
                    ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
