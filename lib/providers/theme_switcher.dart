import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/themes/theme_preferances.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
    (ref) => ThemeNotifier(AppTheme.colorful));

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier(AppTheme theme) : super(theme);

  Future<void> setTheme(theme) async {
    state = theme;
    await ThemePreferances.saveTheme(theme);
  }
}

enum AppTheme { colorful, light, dark }
