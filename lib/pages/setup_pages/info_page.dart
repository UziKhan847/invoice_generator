import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_item_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/dropdown_menu_tile.dart';
import 'package:markaz_umaza_invoice_generator/dropdownmenu/properties.dart/ink_well_size.dart';
import 'package:markaz_umaza_invoice_generator/extensions/context_extension.dart';
import 'package:markaz_umaza_invoice_generator/models/country.dart';
import 'package:markaz_umaza_invoice_generator/models/province.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/utils/regular_expressions.dart';

class InfoPage extends StatefulWidget {
  const InfoPage(
      {super.key,
      required this.controllers,
      required this.orientation,
      required this.selectedCountryIndex,
      required this.updateSlctdCtryIndex});

  final Map<String, TextEditingController> controllers;
  final int selectedCountryIndex;
  final void Function(int) updateSlctdCtryIndex;
  final Orientation orientation;

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  static const double fieldHeight = 65;

  // Layer Link
  late final layerLinks = {
    'country': LayerLink(),
    'prov': LayerLink(),
    'currency': LayerLink(),
  };

  // UI State
  late bool isProvFocused = false;
  late bool isCountryFocused = false;
  late bool isCurrencyFocused = false;

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

  late final keys = {
    'country': GlobalKey(),
    'prov': GlobalKey(),
    'currency': GlobalKey(),
  };

//   // Derived Getters
  String get bnFormat {
    if (widget.selectedCountryIndex == 0) {
      String bnText = widget.controllers['bn']!.text
          .replaceAll(RegExp(r'\s'), '')
          .toUpperCase();
      return '${bnText.substring(0, 9)} ${bnText.substring(9, 11)} ${bnText.substring(11, 15)}';
    }
    return widget.controllers['bn']!.text;
  }

// External Data
  //late AppData provider;

  late List<Country> countries = Countries.countries;

  String getProv(List<Province> prov, int index, String countryIsoTwo) {
    final currentProv = prov[index];
    final iso = currentProv.iso;

    if (iso == null) return currentProv.name;

    return int.tryParse(iso) == null ? iso : '$countryIsoTwo-$iso';
  }

  @override
  void dispose() {
    for (FocusNode node in focusNodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        spacing: 30,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.orientation == Orientation.portrait) ...[
            const Text(
                "This information is required during your initial login and can be updated at a later time.",
                style: TextStyle(fontSize: 16)),
            const Divider(),
          ],

          Text(
            "* required fields",
            style: TextStyle(color: Colors.grey.shade600),
          ),

          //Name Field
          SizedBox(
            height: fieldHeight,
            child: TextFormField(
              focusNode: focusNodes['name']!,
              controller: widget.controllers['name']!,
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
              controller: widget.controllers['bn']!,
              onTapOutside: (_) => focusNodes['bn']!.unfocus(),
              // validator: (value) {
              //   if (widget.selectedCountryIndex == 0) {
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
            controller: widget.controllers['country']!,
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
                  String countryName = Countries.countries[index].name;
                  String countryFlag = Countries.countries[index].flagIcon;
                  String item = "$countryFlag - $countryName";

                  return DropDownItemTile(
                    currentIndex: index,
                    itemFormat: [Text(item)],
                    onTap: () {
                      setState(() {
                        widget.controllers['country']!.text = item;
                        widget.updateSlctdCtryIndex(index);
                        isCountryFocused = !isCountryFocused;
                      });
                      context.removeOverlay();
                    },
                  );
                },
              );
            },
          ),

          if (widget.controllers['country']!.text.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //City
                SizedBox(
                  height: fieldHeight,
                  width: 165,
                  child: TextFormField(
                    focusNode: focusNodes['city']!,
                    controller: widget.controllers['city']!,
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

                //Province DropDown Menu
                DropdownMenuTile(
                  widgetKey: keys['prov']!,
                  layerLink: layerLinks['prov']!,
                  controller: widget.controllers['prov']!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid';
                    }
                    return null;
                  },
                  labelText: "Province*",
                  labelTextSize: 12.5,
                  isFocused: isProvFocused,
                  inkWellSize: const InkWellSize(width: 80),
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
                          .countries[widget.selectedCountryIndex]
                          .provinces
                          .length,
                      itemBuilder: (context, index) {
                        final country = countries[widget.selectedCountryIndex];

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
                              widget.controllers['prov']!.text = item;
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
          if (widget.controllers['country']!.text.isNotEmpty)
            SizedBox(
              height: fieldHeight,
              child: TextFormField(
                focusNode: focusNodes['street']!,
                controller: widget.controllers['street']!,
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

          if (widget.controllers['country']!.text.isNotEmpty &&
              Countries
                      .countries[widget.selectedCountryIndex].postalCodeRegex !=
                  null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Zip
                SizedBox(
                  width: 165,
                  height: fieldHeight,
                  child: TextFormField(
                    focusNode: focusNodes['zip']!,
                    controller: widget.controllers['zip']!,
                    onTapOutside: (_) => focusNodes['zip']!.unfocus(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Zipcode';
                      } else if (!RegExp(Countries
                              .countries[widget.selectedCountryIndex]
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

                //Currency DropDown Menu
                DropdownMenuTile(
                  widgetKey: keys['currency']!,
                  layerLink: layerLinks['currency']!,
                  controller: widget.controllers['currency']!,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Invalid';
                    }
                    return null;
                  },
                  labelText: "Currency*",
                  labelTextSize: 12.5,
                  isFocused: isCurrencyFocused,
                  inkWellSize: const InkWellSize(width: 80),
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
                      itemCount: Countries.currencies.length,
                      itemBuilder: (context, index) {
                        String item = Countries.currencies[index];

                        return DropDownItemTile(
                          currentIndex: index,
                          itemFormat: [Text(item)],
                          height: 50,
                          onTap: () {
                            setState(() {
                              widget.controllers['currency']!.text = item;
                              isCurrencyFocused = !isCurrencyFocused;
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

          if (widget.controllers['country']!.text.isNotEmpty) ...[
            //Phone
            SizedBox(
              height: fieldHeight,
              child: TextFormField(
                focusNode: focusNodes['phone']!,
                controller: widget.controllers['phone']!,
                keyboardType: TextInputType.phone,
                onTapOutside: (_) => focusNodes['phone']!.unfocus(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Phone Number';
                  } else if (!RegExp(Countries
                          .countries[widget.selectedCountryIndex].phoneRegex)
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
              controller: widget.controllers['email']!,
              keyboardType: TextInputType.emailAddress,
              onTapOutside: (_) => focusNodes['email']!.unfocus(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an Email';
                } else if (!RegularExpressions.emailRegex.hasMatch(value)) {
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
              controller: widget.controllers['website']!,
              keyboardType: TextInputType.emailAddress,
              onTapOutside: (_) => focusNodes['website']!.unfocus(),
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
            height: 50,
          )
        ],
      ),
    );
  }
}
