import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/models/country.dart';
import 'package:markaz_umaza_invoice_generator/models/province.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/utils/regular_expressions.dart';

class AddSender extends ConsumerStatefulWidget {
  const AddSender({super.key});

  @override
  ConsumerState<AddSender> createState() => _AddSenderState();
}

class _AddSenderState extends ConsumerState<AddSender> {
  static const double fieldHeight = 65;

// Form
  final _formKey = GlobalKey<FormState>();
  late ScrollPhysics scrollPhysics = const AlwaysScrollableScrollPhysics();

// UI State
  bool isLoading = false;

// Controllers
  final controllers = {
    'name': TextEditingController(),
    'position': TextEditingController(),
    'phone': TextEditingController(),
    'email': TextEditingController(),
    'eTransfer': TextEditingController(),
  };

// Focus Nodes and Keys
  final focusNodes = {
    'name': FocusNode(),
    'position': FocusNode(),
    'phone': FocusNode(),
    'email': FocusNode(),
    'eTransfer': FocusNode(),
  };

  final keys = {
    'country': GlobalKey(),
    'prov': GlobalKey(),
  };

// Derived Getters
  String get bnFormat {
    if (selectedCountryIndex == 0) {
      String bnText =
          controllers['bn']!.text.replaceAll(RegExp(r'\s'), '').toUpperCase();
      return '${bnText.substring(0, 9)} ${bnText.substring(9, 11)} ${bnText.substring(11, 15)}';
    }
    return controllers['bn']!.text;
  }

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
      dialogTitle: "Add Sender",
      onTapAffirm: () async {
        if (_formKey.currentState!.validate()) {
          loadCircle();
          await provider.insertSender(
              context: context,
              name: controllers['name']!.text,
              position: controllers['position']!.text,
              phone: controllers['phone']!.text.isNotEmpty
                  ? controllers['phone']!.text
                  : null,
              email: controllers['email']!.text.isNotEmpty
                  ? controllers['email']!.text
                  : null,
              eTransfer: controllers['eTransfer']!.text.isNotEmpty
                  ? controllers['eTransfer']!.text
                  : null);
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
                  const SizedBox(),

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
                        labelText: "Sender Name*",
                      ),
                    ),
                  ),

                  //Position Field
                  SizedBox(
                    height: fieldHeight,
                    child: TextFormField(
                      focusNode: focusNodes['position']!,
                      controller: controllers['position']!,
                      onTapOutside: (_) => focusNodes['position']!.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your position or N/A';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Position* (N/A if not available)",
                      ),
                    ),
                  ),

                  //Phone
                  SizedBox(
                    height: fieldHeight,
                    child: TextFormField(
                      focusNode: focusNodes['phone']!,
                      controller: controllers['phone']!,
                      keyboardType: TextInputType.phone,
                      onTapOutside: (_) => focusNodes['phone']!.unfocus(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return null;
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
                        labelText: "Phone Number (leave blank if none)",
                      ),
                    ),
                  ),

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
                          return null;
                        } else if (!RegularExpressions.emailRegex
                            .hasMatch(value)) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Email (leave blank if none)",
                      ),
                    ),
                  ),

                  //Etransfer
                  SizedBox(
                    height: fieldHeight,
                    child: TextFormField(
                      focusNode: focusNodes['eTransfer']!,
                      controller: controllers['eTransfer']!,
                      keyboardType: TextInputType.emailAddress,
                      onTapOutside: (_) => focusNodes['eTransfer']!.unfocus(),
                      validator: (value) {
                        if (selectedCountryIndex == 0) {
                          if (value == null || value.isEmpty) {
                            return null;
                          } else if (!RegularExpressions.emailRegex
                              .hasMatch(value)) {
                            return 'Please enter a valid Email';
                          }
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: "Etransfer Email (for Canadians)",
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
