import 'package:flutter/material.dart';

class MyThemes {
  static const Color primaryDark = Color(0xFF000000);
  static const Color secondaryDark = Color(0xFF1E1E1E);
  static const Color tertiaryDark = Color(0xFF323232);

  static const Color primaryLight = Colors.white;
  static const Color secondaryLight = Color(0xFFE1E1E1);
  static const Color tertiaryLight = Color(0xFFCDCDCD);

  static const primaryRed = Color(0xFF6B2C2C);
  static const primaryOrange = Color(0xFF8C5A2E);
  static const primaryBlue = Color(0xFF4A6D8C);
  static const primaryGreen = Color(0xFF3A5A47);
  static const primaryPurple = Color(0xFF5B3A73);

  static const secondaryRed = Color(0xFFF6857D);
  static const secondaryOrange = Color(0xFFFFCA8A);
  static const secondaryBlue = Color(0xFFA3CEFF);
  static const secondaryGreen = Color(0xFFA5FFCB);
  static const secondaryPurple = Color(0xFFDDB9FF);

  static InputDecoration loginSignupTextField(
      {String? labelText,
      Color? labelColor,
      Color? floatingLabelColor,
      Widget? suffixIcon,
      double? labelFontSize}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: labelColor,
        fontSize: labelFontSize,
      ),
      floatingLabelStyle: TextStyle(
        fontSize: 20,
        color: floatingLabelColor,
        fontWeight: FontWeight.bold,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      isDense: false,
      errorStyle: const TextStyle(height: 0, fontSize: 11),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF616161)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
            color: floatingLabelColor ?? const Color(0xFF135993), width: 2),
      ),
      errorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF44336)),
      ),
      focusedErrorBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFF44336)),
      ),
      disabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF616161)),
      ),
      suffixIcon: suffixIcon,
    );
  }

  static final colorfulTheme = getThemeData(
    brightness: Brightness.light,
    appBarBackColor: primaryRed,
    appBarForeColor: Colors.white,
    circlePrgrssIndicColor: primaryLight,
    dialogBackColor: const Color(0xFFfff7ff),
    dialogTitleColor: secondaryDark,
    elvtdBtnBackColor: Colors.white,
    elvtdBtnForeColor: Colors.black,
    fltnActBtnBackColor: primaryRed,
    fltnActBtnForeColor: Colors.white,
    iconColor: primaryDark,
    scaffoldBackgroundColor: primaryRed,
  );

  static final lightTheme = getThemeData(
    brightness: Brightness.light,
    appBarBackColor: secondaryLight,
    appBarForeColor: secondaryDark,
    circlePrgrssIndicColor: primaryDark,
    dialogBackColor: primaryLight,
    dialogTitleColor: secondaryDark,
    elvtdBtnBackColor: secondaryLight,
    elvtdBtnForeColor: primaryDark,
    fltnActBtnBackColor: tertiaryLight,
    fltnActBtnForeColor: primaryDark,
    iconColor: primaryDark,
    scaffoldBackgroundColor: secondaryLight,
  );

  static final darkTheme = getThemeData(
    brightness: Brightness.dark,
    appBarBackColor: secondaryDark,
    appBarForeColor: secondaryLight,
    circlePrgrssIndicColor: primaryLight,
    dialogBackColor: secondaryDark,
    dialogTitleColor: secondaryLight,
    elvtdBtnBackColor: tertiaryDark,
    elvtdBtnForeColor: primaryLight,
    fltnActBtnBackColor: primaryDark,
    fltnActBtnForeColor: secondaryLight,
    labelColor: tertiaryLight,
    iconColor: primaryLight,
    inputBrdrClr: const Color(0xFF7e7e7e),
    scaffoldBackgroundColor: primaryDark,
  );

  static ThemeData getThemeData({
    Brightness? brightness,
    Color? appBarBackColor,
    Color? appBarForeColor,
    Color? circlePrgrssIndicColor,
    Color? dialogBackColor,
    Color? dialogTitleColor,
    Color? elvtdBtnBackColor,
    Color? elvtdBtnForeColor,
    Color? fltnActBtnBackColor,
    Color? fltnActBtnForeColor,
    Color? iconColor,
    Color inputBrdrClr = const Color(0xFF616161),
    Color errorBrdrClr = const Color(0xFFF44336),
    Color focusedBrdrClr = const Color(0xFF135993),
    Color disabledBrdrClr = const Color(0xFF616161),
    Color focusedErrorBrdrClr = primaryRed,
    Color? labelColor,
    double? labelFontSize,
    Color? scaffoldBackgroundColor,
    Color? onPrimary,
    Color? onSecondary,
    Color? onTertiary,
    Color? primary,
    Color? secondary,
    Color? tertiary,
  }) =>
      ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: appBarBackColor,
            centerTitle: true,
            elevation: 4,
            foregroundColor: appBarForeColor,
            shadowColor: Colors.black,
          ),
          brightness: brightness,
          dialogTheme: DialogTheme(
            backgroundColor: dialogBackColor,
            titleTextStyle: TextStyle(color: dialogTitleColor),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(elvtdBtnBackColor),
              elevation: const WidgetStatePropertyAll(4),
              //fixedSize: const WidgetStatePropertyAll(Size(105, 20)),
              minimumSize: const WidgetStatePropertyAll(Size(105, 40)),
              foregroundColor: WidgetStatePropertyAll(elvtdBtnForeColor),
              overlayColor: WidgetStatePropertyAll(secondary),
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: fltnActBtnBackColor,
            elevation: 4,
            foregroundColor: fltnActBtnForeColor,
            shape: const CircleBorder(),
          ),
          iconTheme: IconThemeData(color: iconColor),
          inputDecorationTheme: InputDecorationTheme(
            isDense: true,
            errorStyle: const TextStyle(height: 0, fontSize: 11),
            labelStyle: TextStyle(
              color: labelColor,
              fontSize: labelFontSize,
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: inputBrdrClr)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedBrdrClr)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: errorBrdrClr)),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: focusedErrorBrdrClr)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: disabledBrdrClr)),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: circlePrgrssIndicColor,
          ));
}
