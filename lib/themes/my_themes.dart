import 'package:flutter/material.dart';

class MyThemes {
  static const Color primaryDark = Color(0xFF000000);
  static const Color secondaryDark = Color(0xFF1E1E1E);
  static const Color tertiaryDark = Color(0xFF323232);

  static const Color primaryLight = Colors.white;
  static const Color secondaryLight = Color(0xFFE1E1E1);
  static const Color tertiaryLight = Color(0xFFCDCDCD);

  static final colorfulTheme = getThemeData(
    brightness: Brightness.light,
    appBarBackColor: const Color(0xFF6B2C2C),
    appBarForeColor: Colors.white,
    dialogBackColor: const Color(0xFFfff7ff),
    dialogTitleColor: secondaryDark,
    elvtdBtnBackColor: Colors.white,
    elvtdBtnForeColor: Colors.black,
    fltnActBtnBackColor: const Color(0xFF6B2C2C),
    fltnActBtnForeColor: Colors.white,
    iconColor: primaryDark,
    scaffoldBackgroundColor: secondaryLight,
  );

  static final lightTheme = getThemeData(
    brightness: Brightness.light,
    appBarBackColor: secondaryLight,
    appBarForeColor: secondaryDark,
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
    dialogBackColor: secondaryDark,
    dialogTitleColor: secondaryLight,
    elvtdBtnBackColor: tertiaryDark,
    elvtdBtnForeColor: primaryLight,
    fltnActBtnBackColor: tertiaryDark,
    fltnActBtnForeColor: primaryLight,
    iconColor: primaryLight,
    scaffoldBackgroundColor: primaryDark,
  );

  static ThemeData getThemeData({
    Brightness? brightness,
    Color? appBarBackColor,
    Color? appBarForeColor,
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
            fixedSize: const WidgetStatePropertyAll(Size(105, 20)),
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
          border:
              OutlineInputBorder(borderSide: BorderSide(color: inputBrdrClr)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: focusedBrdrClr)),
          errorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: errorBrdrClr)),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: errorBrdrClr)),
          disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF616161))),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
      );
}
