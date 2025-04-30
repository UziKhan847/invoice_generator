import 'package:markaz_umaza_invoice_generator/JSON/country_data.dart';
import 'package:markaz_umaza_invoice_generator/models/country.dart';

class Countries {
  static final countries = countryData.map(Country.fromJson).toList();

  static final currencies = countries.map((e) => e.currency).toSet().toList()
    ..sort();
}
