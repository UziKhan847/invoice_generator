import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markaz_umaza_invoice_generator/themes/theme_preferances.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
    (ref) => ThemeNotifier(AppTheme.colorful));

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier(super.state);

  Future<void> setTheme(AppTheme theme) async {
    state = theme;
    await ThemePreferances.saveTheme(theme);
  }
}

enum AppTheme { colorful, light, dark }
