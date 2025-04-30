import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_data_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/setup_pages/image_upload_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/setup_pages/info_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/widgets/flexible_column_row.dart';
import 'package:markaz_umaza_invoice_generator/widgets/flexible_row_column.dart';

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

  // Form
  late final _formKey = GlobalKey<FormState>();

  // UI State
  late bool isLoading = false;

// // Controllers
  late final pageControllers = [PageController(), PageController()];
  late final controllers = {
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

  bool get fieldsIncomplete {
    return controllers.entries.any((entry) {
      final key = entry.key;
      final value = entry.value.text;

      if (key == 'bn' || key == 'website') return false;

      if (key == 'zip') {
        if (Countries.countries[selectedCountryIndex].postalCodeRegex != null) {
          return false;
        }
      }

      return value.isEmpty;
    });
  }

  bool onPageTwo = false;

// External Data
  //late AppData provider;

  late int selectedCountryIndex = 0;

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

    // pageControllers[1].addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    for (PageController e in pageControllers) {
      e.dispose();
    }
    for (TextEditingController e in controllers.values) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    themeMode = ref.read(themeProvider);
    final orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: PageView(
        controller: pageControllers[0],
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
                        child: Text(
                            "This information is required during your initial login and can be updated at a later time.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: textColor)),
                      ),
                    ],
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 35, right: 25, left: 25),
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: 315,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? MyThemes.secondaryDark
                          : MyThemes.primaryLight,
                      borderRadius: BorderRadius.circular(24)),
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageControllers[1],
                    children: [
                      InfoPage(
                        controllers: controllers,
                        selectedCountryIndex: selectedCountryIndex,
                        updateSlctdCtryIndex: updateSlctdCtryIndex,
                        orientation: orientation,
                      ),
                      const ImageUploadPage()
                    ],
                  ),
                ),
                FlexibleRowColumn(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onPageTwo)
                      ElevatedButton(
                        style: const ButtonStyle(
                          minimumSize: WidgetStatePropertyAll(Size(115, 40)),
                        ),
                        onPressed: () {
                          pageControllers[1].previousPage(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeIn);
                          setState(() {
                            onPageTwo = false;
                          });
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('‹',
                                style: TextStyle(
                                    fontSize: 22)), // This shows a right arrow
                            Text(
                              '  Back',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    // if (fieldsIncomplete == false)
                    ElevatedButton(
                      style: const ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(115, 40)),
                      ),
                      onPressed: () {
                        //if (_formKey.currentState!.validate()) {
                        pageControllers[0].nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeIn);
                        setState(() {
                          onPageTwo = true;
                        });
                        // }
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
              ],
            ),
          ),
          const LoadingDataPage(),
        ],
      ),
    );
  }
}
