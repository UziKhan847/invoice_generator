import 'package:shared_preferences/shared_preferences.dart';

class CurrencyPreferances {
  static const key = 'currency';

  static Future<void> saveCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, currency);
  }

  static Future<String> getCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final currency = prefs.getString(key);
    return currency!;
  }
}
