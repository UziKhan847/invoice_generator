extension StringExtension on String {
  String get toCapitalized => replaceFirst(this[0], this[0].toUpperCase());

}