import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/keys.dart';
import 'package:markaz_umaza_invoice_generator/pages/loading_screen_page.dart';
import 'package:markaz_umaza_invoice_generator/pages/main_page.dart';
import 'package:markaz_umaza_invoice_generator/providers/app_data.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/themes/theme_preferances.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  await Supabase.initialize(
    url: supabaseUrlKey,
    anonKey: supabaseAnonKey,
  );

  final savedTheme = await ThemePreferances.getSavedTheme();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(ProviderScope(
    overrides: [themeProvider.overrideWith((ref) => ThemeNotifier(savedTheme))],
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  late AppData provider;
  late AppTheme themeMode;
  late final data = provider.getData();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    provider = ref.watch(appData);
    themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: "Invoice Generator",
      debugShowCheckedModeBanner: false,
      theme: themeMode == AppTheme.colorful
          ? MyThemes.colorfulTheme
          : MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeMode == AppTheme.dark ? ThemeMode.dark : ThemeMode.light,
      home:
          // TabsPage()
          FutureBuilder(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  return const MainPage();
                }

                return const LoadingScreenPage();
              }),
    );
  }
}
