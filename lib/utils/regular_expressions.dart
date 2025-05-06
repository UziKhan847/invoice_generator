class RegularExpressions {
  static final emailRegex = RegExp(r'^.+@[0-z]+\.[A-z]+$');
  static final bnRegex = RegExp(r'^\d{9}\s?[A-z]{2}\s?\d{4}$');
  static final numTwoDecimalsRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  static final leadingZerosRegex = RegExp(r'^0+\d');
}
