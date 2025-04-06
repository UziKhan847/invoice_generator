import 'package:flutter/material.dart';
import 'package:markaz_umaza_invoice_generator/providers/theme_switcher.dart';

class MyThemes {
  static ThemeData lightTheme(AppTheme themeMode) => themeMode ==
          AppTheme.colorful
      ? ThemeData(
          scaffoldBackgroundColor: const Color(0xFFD9D9D9),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF6B2C2C),
              foregroundColor: Colors.white,
              shadowColor: Colors.black,
              elevation: 4,
              centerTitle: true),
          listTileTheme: const ListTileThemeData(
              titleTextStyle: TextStyle(fontSize: 20),
              textColor: Colors.black,
              tileColor: Color(0xFFF7F7F7)),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF6B2C2C),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: CircleBorder(),
          ),
          elevatedButtonTheme: const ElevatedButtonThemeData(
              style: ButtonStyle(
            fixedSize: WidgetStatePropertyAll(Size(95, 20)),
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
            elevation: WidgetStatePropertyAll(4),
            overlayColor: WidgetStatePropertyAll(Color(0xFFDDDDDD)),
          )),
          inputDecorationTheme: const InputDecorationTheme(
              isDense: true,
              iconColor: Color(0xFF6A6A6A),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(
                color: Color(0xFF6A6A6A),
              ),
              errorStyle: TextStyle(height: 0, fontSize: 11),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF616161))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF135993))),
              errorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              focusedErrorBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
              disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF616161)))),
          dialogTheme: const DialogTheme(backgroundColor: Color(0xFFF7F7F7)),
        )
      : ThemeData.light();

  static ThemeData darkTheme() => ThemeData(
        scaffoldBackgroundColor: const Color(0xFF201a1a),
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2A2A2A),
            foregroundColor: Colors.white,
            shadowColor: Colors.black,
            elevation: 4,
            centerTitle: true),
        listTileTheme: const ListTileThemeData(
            titleTextStyle: TextStyle(fontSize: 20),
            textColor: Colors.black,
            tileColor: Color(0xFFF7F7F7)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF2A2A2A),
          foregroundColor: Colors.white,
          elevation: 4,
          shape: CircleBorder(),
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
            style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(Size(105, 20)),
          backgroundColor: WidgetStatePropertyAll(
            Color(0xFF343434),
          ),
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          elevation: WidgetStatePropertyAll(4),
          overlayColor: WidgetStatePropertyAll(
            Color(0xFF2A2A2A),
          ),
        )),
        inputDecorationTheme: const InputDecorationTheme(
            isDense: true,
            iconColor: Color(0xFF6A6A6A),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: TextStyle(
              color: Color(0xFF6A6A6A),
            ),
            errorStyle: TextStyle(height: 0, fontSize: 11),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF616161))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF135993))),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF616161)))),
        dialogTheme: const DialogTheme(backgroundColor: Color(0xFFF7F7F7)),
      );
}
