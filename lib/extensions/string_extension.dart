extension StringExtension on String {
  String get toCapitalized => replaceFirst(this[0], this[0].toUpperCase());

  String get countryName {
    final parts = split(' - ');
    return parts.length == 2 ? parts.last : this;
  }
}