import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/extensions/string_extension.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/tiles/dialog_tile.dart';
import 'package:markaz_umaza_invoice_generator/utils/countries.dart';
import 'package:markaz_umaza_invoice_generator/widgets/setup_page_widgets/setup_form_fields.dart';

class UpdateProfile extends ConsumerStatefulWidget {
  const UpdateProfile({super.key});

  @override
  ConsumerState<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends ConsumerState<UpdateProfile> {
  late bool isInitialized = false;

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

  late final profileMap = {
    'name': provider.profile.fullName,
    'bn': provider.profile.businessNumber,
    'street': provider.profile.street,
    'city': provider.profile.city,
    'prov': provider.profile.province,
    'country': provider.profile.country,
    'zip': provider.profile.zip,
    'phone': provider.profile.phone,
    'email': provider.profile.email,
    'website': provider.profile.website,
    'currency': provider.profile.currency,
  };

// Form Logic
  bool get fieldsIncomplete {
    return controllers.entries.any((entry) {
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
    for (TextEditingController e in controllers.values) {
      e.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    provider = ref.watch(appData);
    final orientation = MediaQuery.of(context).orientation;

    if (!isInitialized) {
      profileMap.forEach((key, value) {
        controllers[key]?.text = value ?? '';
      });
    }

    isInitialized = true;
    return DialogTile(
      affirmButtonText: "Add",
      cancelButtonText: "Cancel",
      isLoading: isLoading,
      dialogHeight: 250,
      dialogTitle: "Add Recipeint",
      onTapAffirm: () async {
        if (_formKey.currentState!.validate()) {
          loadCircle();
          await provider.updateProfile(
            context: context,
            fullName: controllers['name']!.text,
            website: controllers['website']!.text.isNotEmpty
                ? controllers['website']!.text
                : null,
            country: controllers['country']!.text.countryName,
            street: controllers['street']!.text,
            city: controllers['city']!.text,
            prov: controllers['prov']!.text,
            zip: controllers['zip']!.text.isNotEmpty
                ? controllers['zip']!.text
                : null,
            phone: controllers['phone']!.text,
            email: controllers['email']!.text,
            businessNumber: controllers['bn']!.text.isNotEmpty
                ? controllers['bn']!.text
                : null,
            currency: controllers['currency']!.text,
            logoUrl: provider.profile.logoUrl,
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
          child: SetupFormFields(
              controllers: controllers,
              orientation: orientation,
              selectedCountryIndex: selectedCountryIndex,
              updateSlctdCtryIndex: updateSlctdCtryIndex),
        ),
      ),
    );
  }
}
