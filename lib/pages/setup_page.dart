import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/country.dart';
import 'package:markaz_umaza_invoice_generator/models/province.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_data_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/utils/regular_expressions.dart';
import 'package:markaz_umaza_invoice_generator/widgets/flexible_column_row.dart';

class SetupPage extends ConsumerStatefulWidget {
  const SetupPage({super.key});

  @override
  ConsumerState<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends ConsumerState<SetupPage> {
  // Theme
  late AppTheme themeMode;

  Color? get textColor =>
      themeMode == AppTheme.colorful ? MyThemes.primaryLight : null;

  static const double fieldHeight = 65;

  // Form
  late final _formKey = GlobalKey<FormState>();

  // Layer Link
  late final layerLinks = {
    'country': LayerLink(),
    'prov': LayerLink(),
    'currency': LayerLink(),
  };

  // UI State
  late bool isLoading = false;
  late bool isProvFocused = false;
  late bool isCountryFocused = false;
  late bool isCurrencyFocused = false;

// // Controllers
  late final controller = PageController();
  final controllers = {
    'name': TextEditingController(),
    'bn': TextEditingController(),
    'street': TextEditingController(),
    'city': TextEditingController(),
    'prov': TextEditingController(),
    'country': TextEditingController(),
    'zip': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'website': TextEditingController(),
    'currency': TextEditingController(),
  };

  // Focus Nodes and Keys
  late final focusNodes = {
    'name': FocusNode(),
    'bn': FocusNode(),
    'street': FocusNode(),
    'city': FocusNode(),
    'zip': FocusNode(),
    'phone': FocusNode(),
    'email': FocusNode(),
    'website': FocusNode(),
    'currency': FocusNode(),
  };

  final keys = {
    'country': GlobalKey(),
    'prov': GlobalKey(),
    'currency': GlobalKey(),
  };

//   // Derived Getters
  String get bnFormat {
    if (selectedCountryIndex == 0) {
      String bnText =
          controllers['bn']!.text.replaceAll(RegExp(r'\s'), '').toUpperCase();
      return '${bnText.substring(0, 9)} ${bnText.substring(9, 11)} ${bnText.substring(11, 15)}';
    }
    return controllers['bn']!.text;
  }

  bool get fieldsIncomplete {
    return controllers.entries.any((entry) {
      final key = entry.key;
      final value = entry.value.text;

      if (key == 'bn') return false;

      if (key == 'zip') {
        if (Countries.countries[selectedCountryIndex].postalCodeRegex != null) {
          return false;
        }
      }

      return value.isEmpty;
    });
  }

// External Data
  //late AppData provider;

  int selectedCountryIndex = 0;

  late List<Country> countries = Countries.countries;

  String getProv(List<Province> prov, int index, String countryIsoTwo) {
    final currentProv = prov[index];
    final iso = currentProv.iso;

    if (iso == null) return currentProv.name;

    return int.tryParse(iso) == null ? iso : '$countryIsoTwo-$iso';
  }

  void loadCircle() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    for (TextEditingController e in controllers.values) {
      e.dispose();
    }
    for (FocusNode node in focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeMode = ref.read(themeProvider);

    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Form(
            key: _formKey,
            child: FlexibleColumnRow(
              spacing: 32,
              mainAxisAlignment: MainAxisAlignment.center,
              //mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Get started!",
                  style: TextStyle(fontSize: 34, color: textColor),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 35, right: 25, left: 25),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: 315,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? MyThemes.secondaryDark
                          : MyThemes.primaryLight,
                      borderRadius: BorderRadius.circular(24)),
                  child: SingleChildScrollView(
                    child: Column(
                      spacing: 30,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "* required fields",
                          style: TextStyle(color: Colors.grey.shade600),
                        ),

                        //Name Field
                        SizedBox(
                          height: fieldHeight,
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
                              labelText: "Business/Independent Name*",
                            ),
                          ),
                        ),

                        //BN Field
                        SizedBox(
                          height: fieldHeight,
                          child: TextFormField(
                            focusNode: focusNodes['bn']!,
                            controller: controllers['bn']!,
                            onTapOutside: (_) => focusNodes['bn']!.unfocus(),
                            // validator: (value) {
                            //   if (selectedCountryIndex == 0) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter a Business Number';
                            //     } else if (value.length < 15) {
                            //       return 'Min. is 15 characters w/o spaces';
                            //     } else if (value.length > 17) {
                            //       return 'Max. is 17 characters with spaces';
                            //     } else if (!RegularExpressions.bnRegex
                            //         .hasMatch(value)) {
                            //       return "Invalid Business Number";
                            //     }
                            //   }

                            //   return null;
                            // },
                            decoration: const InputDecoration(
                              labelText: "Business Number",
                            ),
                          ),
                        ),

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
                          isFocused: isCountryFocused,
                          onTap: () {
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
                                String countryName =
                                    Countries.countries[index].name;
                                String countryFlag =
                                    Countries.countries[index].flagIcon;
                                String item = "$countryFlag - $countryName";

                                return DropDownItemTile(
                                  currentIndex: index,
                                  itemFormat: [Text(item)],
                                  onTap: () {
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

                        if (controllers['country']!.text.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //City
                              SizedBox(
                                height: fieldHeight,
                                width: 185,
                                child: TextFormField(
                                  focusNode: focusNodes['city']!,
                                  controller: controllers['city']!,
                                  onTapOutside: (_) =>
                                      focusNodes['city']!.unfocus(),
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
                                inkWellSize: const InkWellSize(width: 73),
                                onTap: () {
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
                                      final country =
                                          countries[selectedCountryIndex];

                                      String item = getProv(
                                        country.provinces,
                                        index,
                                        country.countryCode.isoTwo,
                                      );

                                      return DropDownItemTile(
                                        currentIndex: index,
                                        itemFormat: [Text(item)],
                                        height: 50,
                                        onTap: () {
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
                          ),
                        ],

                        //Street
                        if (controllers['country']!.text.isNotEmpty)
                          SizedBox(
                            height: fieldHeight,
                            child: TextFormField(
                              focusNode: focusNodes['street']!,
                              controller: controllers['street']!,
                              onTapOutside: (_) =>
                                  focusNodes['street']!.unfocus(),
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

                        if (controllers['country']!.text.isNotEmpty &&
                            Countries.countries[selectedCountryIndex]
                                    .postalCodeRegex !=
                                null) ...[
                          //Zip
                          SizedBox(
                            width: 100,
                            height: fieldHeight,
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
                        ],

                        //Currency DropDown Menu
                        DropdownMenuTile(
                          widgetKey: keys['currency']!,
                          layerLink: layerLinks['currency']!,
                          controller: controllers['currency']!,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Invalid';
                            }
                            return null;
                          },
                          labelText: "Currency*",
                          labelTextSize: 12.5,
                          isFocused: isCurrencyFocused,
                          inkWellSize: const InkWellSize(width: 73),
                          onTap: () {
                            setState(() {
                              isCurrencyFocused = !isCurrencyFocused;
                            });

                            context.insertOverlay(
                              context: context,
                              widgetKey: keys['currency']!,
                              layerLink: layerLinks['currency']!,
                              onTapOutsideOverlay: () {
                                setState(() {
                                  isCurrencyFocused = !isCurrencyFocused;
                                });
                                context.removeOverlay();
                              },
                              itemCount: Countries
                                  .countries[selectedCountryIndex]
                                  .currency
                                  .length,
                              itemBuilder: (context, index) {
                                final country = countries[selectedCountryIndex];

                                String item = country.currency;

                                return DropDownItemTile(
                                  currentIndex: index,
                                  itemFormat: [Text(item)],
                                  height: 50,
                                  onTap: () {
                                    setState(() {
                                      controllers['currency']!.text = item;
                                      isCurrencyFocused = !isCurrencyFocused;
                                    });
                                    context.removeOverlay();
                                  },
                                );
                              },
                            );
                          },
                        ),

                        if (controllers['country']!.text.isNotEmpty) ...[
                          //Phone
                          SizedBox(
                            height: fieldHeight,
                            child: TextFormField(
                              focusNode: focusNodes['phone']!,
                              controller: controllers['phone']!,
                              keyboardType: TextInputType.phone,
                              onTapOutside: (_) =>
                                  focusNodes['phone']!.unfocus(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a Phone Number';
                                } else if (!RegExp(Countries
                                        .countries[selectedCountryIndex]
                                        .phoneRegex)
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
                        ],

                        //Email
                        SizedBox(
                          height: fieldHeight,
                          child: TextFormField(
                            focusNode: focusNodes['email']!,
                            controller: controllers['email']!,
                            keyboardType: TextInputType.emailAddress,
                            onTapOutside: (_) => focusNodes['email']!.unfocus(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an Email';
                              } else if (!RegularExpressions.emailRegex
                                  .hasMatch(value)) {
                                return 'Please enter a valid Email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              labelText: "Email*",
                            ),
                          ),
                        ),

                        // Website
                        SizedBox(
                          height: fieldHeight,
                          child: TextFormField(
                            focusNode: focusNodes['website']!,
                            controller: controllers['website']!,
                            keyboardType: TextInputType.emailAddress,
                            onTapOutside: (_) =>
                                focusNodes['website']!.unfocus(),
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return 'Please enter an Website';
                            //   } else if (!RegularExpressions.emailRegex
                            //       .hasMatch(value)) {
                            //     return 'Please enter a valid Website';
                            //   }
                            //   return null;
                            // },
                            decoration: const InputDecoration(
                              labelText: "Website",
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                ),
                if (fieldsIncomplete == false)
                  ElevatedButton(
                    style: const ButtonStyle(
                      minimumSize: WidgetStatePropertyAll(Size(115, 50)),
                    ),
                    onPressed: () {
                      controller.nextPage(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.linear);
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Next  ',
                          style: TextStyle(fontSize: 18),
                        ),

                        Text('›',
                            style: TextStyle(
                                fontSize: 22)), // This shows a right arrow
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const LoadingDataPage(),
        ],
      ),
    );
  }
}
