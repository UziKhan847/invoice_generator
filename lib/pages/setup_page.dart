import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/extensions/string_extension.dart';
import 'package:markaz_umaza_invoice_generator/handlers/image_handler.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_data_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_screen_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/providers/logo_image_data.dart';
import 'package:markaz_umaza_invoice_generator/widgets/setup_page_widgets/logo_upload.dart';
import 'package:markaz_umaza_invoice_generator/widgets/setup_page_widgets/setup_form_fields.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/widgets/flexible_column_row.dart';
import 'package:markaz_umaza_invoice_generator/widgets/flexible_row_column.dart';
import 'package:markaz_umaza_invoice_generator/widgets/setup_page_widgets/page_nav_button.dart';

class SetupPage extends ConsumerStatefulWidget {
  const SetupPage({super.key});

  @override
  ConsumerState<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends ConsumerState<SetupPage> {
// Theme & Styling
  late AppTheme themeMode;

  Color? get textColor =>
      themeMode == AppTheme.colorful ? MyThemes.primaryLight : null;

// Providers & Data
  late AppData provider;

// Form State & Keys
  late final _formKey = GlobalKey<FormState>();
  late final pageKey = const PageStorageKey('outerPage');

// UI State
  bool onPageTwo = false;
  late bool isLoading = false;
  late int selectedCountryIndex = 0;

// Page & Input Controllers
  late final setupPageController = PageController();
  late final formFlowController = PageController();

  late final textControllers = {
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

// Form Logic
  bool get fieldsIncomplete {
    return textControllers.entries.any((entry) {
      final key = entry.key;
      final value = entry.value.text;

      if (key == 'bn' || key == 'website') return false;

      if (key == 'zip') {
        final country = Countries.countries[selectedCountryIndex];
        if (country.postalCodeRegex != null) return false;
      }

      return value.isEmpty;
    });
  }

// Helpers
  EdgeInsets getPageMargins(bool onPageTwo, Orientation orientation) {
    if (!onPageTwo) {
      return const EdgeInsets.only(top: 35, bottom: 0, right: 25, left: 25);
    }
    return orientation == Orientation.portrait
        ? const EdgeInsets.symmetric(vertical: 35, horizontal: 25)
        : const EdgeInsets.symmetric(vertical: 0, horizontal: 25);
  }

  void updateSlctdCtryIndex(int index) {
    setState(() {
      selectedCountryIndex = index;
    });
  }

  void loadCircle() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    setupPageController.dispose();
    formFlowController.dispose();
    for (TextEditingController e in textControllers.values) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeMode = ref.read(themeProvider);
    provider = ref.read(appData);
    final imageBytes = ref.watch(logoImageProvider);

    final orientation = MediaQuery.of(context).orientation;
    final logoUrl = "${provider.userId}_compressed_logo.png";

    final imageHandler = ImageHandler(logoUrl: logoUrl);

    return Scaffold(
      body: PageView(
        controller: setupPageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Form(
            key: _formKey,
            child: FlexibleColumnRow(
              spacing: 32,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Get started!",
                      style: TextStyle(fontSize: 34, color: textColor),
                    ),
                    if (orientation == Orientation.landscape) ...[
                      SizedBox(
                        width: 181,
                        child: Divider(
                          thickness: 1,
                          color: textColor,
                        ),
                      ),
                      SizedBox(
                        width: 181,
                        child: onPageTwo
                            ? Column(
                                children: [
                                  Text(
                                    "Upload a Logo",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: textColor),
                                  ),
                                  Text(
                                    "Optional. Can be uploaded later; otherwise, the app icon will be used as the default logo.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: textColor),
                                  ),
                                ],
                              )
                            : Text(
                                "This information is required during your initial login and can be updated at a later time.",
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(fontSize: 16, color: textColor)),
                      ),
                    ],
                  ],
                ),
                Container(
                  padding: getPageMargins(onPageTwo, orientation),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: 315,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? MyThemes.secondaryDark
                          : MyThemes.primaryLight,
                      borderRadius: BorderRadius.circular(24)),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: formFlowController,
                    key: pageKey,
                    onPageChanged: (value) {},
                    children: [
                      SetupFormFields(
                        isSetup: true,
                        controllers: textControllers,
                        selectedCountryIndex: selectedCountryIndex,
                        updateSlctdCtryIndex: updateSlctdCtryIndex,
                        orientation: orientation,
                      ),
                      LogoUpload(
                        orientation: orientation,
                        logoUrl: logoUrl,
                      )
                    ],
                  ),
                ),
                FlexibleRowColumn(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onPageTwo)
                      PageNavButton(
                          btnType: PageNavButtonType.back,
                          onPressed: () {
                            formFlowController.previousPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeIn);

                            setState(() {
                              onPageTwo = false;
                            });
                          }),
                    PageNavButton(
                      btnType: onPageTwo
                          ? PageNavButtonType.finish
                          : PageNavButtonType.next,
                      onPressed: onPageTwo
                          ? () async {
                              await setupPageController.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeIn);

                              if (context.mounted) {
                                await provider.updateProfile(
                                  context: context,
                                  fullName: textControllers['name']!.text,
                                  website: textControllers['website']!
                                          .text
                                          .isNotEmpty
                                      ? textControllers['website']!.text
                                      : null,
                                  country: textControllers['country']!
                                      .text
                                      .countryName,
                                  street: textControllers['street']!.text,
                                  city: textControllers['city']!.text,
                                  prov: textControllers['prov']!.text,
                                  zip: textControllers['zip']!.text.isNotEmpty
                                      ? textControllers['zip']!.text
                                      : null,
                                  phone: textControllers['phone']!.text,
                                  email: textControllers['email']!.text,
                                  businessNumber:
                                      textControllers['bn']!.text.isNotEmpty
                                          ? textControllers['bn']!.text
                                          : null,
                                  currency: textControllers['currency']!.text,
                                  logoUrl: imageBytes != null ? logoUrl : null,
                                );
                              }

                              if (imageBytes != null && context.mounted) {
                                await imageHandler.uploadAndSaveImage(
                                    context, imageBytes);
                              }

                              setupPageController.jumpToPage(
                                  setupPageController.page!.toInt() + 1);
                            }
                          : () {
                              if (_formKey.currentState!.validate()) {
                                formFlowController.nextPage(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeIn);
                                setState(() {
                                  onPageTwo = true;
                                });
                              }
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const LoadingScreenPage(),
          const LoadingDataPage(),
        ],
      ),
    );
  }
}
