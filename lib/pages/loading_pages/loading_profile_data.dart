import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/page_views/loading_page_view.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_logo_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_pages/loading_screen_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/setup_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';

class LoadingProfileData extends ConsumerStatefulWidget {
  const LoadingProfileData({super.key});

  @override
  ConsumerState<LoadingProfileData> createState() => _LoadingProfileDataState();
}

class _LoadingProfileDataState extends ConsumerState<LoadingProfileData> {
  late AppData provider;
  late Future<void> data;

  @override
  void initState() {
    super.initState();
    provider = ref.read(appData);
    data = provider.getProfileData();
  }

  // bool isNull(Profile profile) {
  //   return [
  //     profile.fullName,
  //     profile.country,
  //     profile.province,
  //     profile.city,
  //     profile.street,
  //     profile.email,
  //     profile.phone,
  //     profile.currency,
  //   ].any((field) => field == null);
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          if (provider.profile.isIncomplete) {
            return const LoadingPageView(
              secondPage: SetupPage(),
            );
          }

          // if (provider.profile.isIncomplete) {
          //   return SetupPage(); //First Login Page
          // }

          return const LoadingLogoPage();
        }
        return const LoadingScreenPage();
      },
    );
  }
}
