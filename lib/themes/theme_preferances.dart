import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferances {
  static const key = 'themeIndex';

  static Future<void> saveTheme(AppTheme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, theme.index);
  }

  static Future<AppTheme> getSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(key) ?? 0;
    return AppTheme.values[index];
  }
}
