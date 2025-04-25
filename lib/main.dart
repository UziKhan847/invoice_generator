import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/keys.dart';
import 'package:markaz_umaza_invoice_generator/page_views/auth_state_page_view.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:markaz_umaza_invoice_generator/themes/my_themes.dart';
import 'package:markaz_umaza_invoice_generator/themes/theme_preferances.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  late AppTheme themeMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: "Invoice Generator",
      debugShowCheckedModeBanner: false,
      theme: themeMode == AppTheme.colorful
          ? MyThemes.colorfulTheme
          : MyThemes.lightTheme,
      darkTheme: MyThemes.darkTheme,
      themeMode: themeMode == AppTheme.dark ? ThemeMode.dark : ThemeMode.light,
      home: const AuthStatePageView(),
    );
  }
}
