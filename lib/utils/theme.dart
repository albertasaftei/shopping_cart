import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = Colors.indigo;
  Color darkPrimaryColor = Colors.indigoAccent;

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      primary: theme.lightPrimaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => theme.lightPrimaryColor),
        minimumSize: MaterialStateProperty.resolveWith(
          (states) => const Size(double.infinity, 40),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => const TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.white,
        ),
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.indigo,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark().copyWith(
      primary: theme.darkPrimaryColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.resolveWith(
          (states) => const Size(double.infinity, 40),
        ),
        shape: MaterialStateProperty.resolveWith(
          (states) => RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
            (states) => theme.darkPrimaryColor),
        textStyle: MaterialStateProperty.resolveWith(
          (states) => const TextStyle(color: Colors.white),
        ),
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => Colors.white,
        ),
      ),
    ),
  );
}

ThemeClass theme = ThemeClass();
