import 'package:flutter/material.dart';

final whiteTheme = ThemeData(
  highlightColor: Colors.transparent,
  primaryColor: const Color.fromRGBO(60, 105, 220, 1),
  scaffoldBackgroundColor: Colors.white,
  colorScheme:
      ColorScheme.fromSeed(seedColor: const Color.fromRGBO(60, 105, 220, 1)),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    // foregroundColor: Colors.deepPurple,
    titleSpacing: 20,
    titleTextStyle: TextStyle(
      fontFamily: "Montserrat",
      color: Colors.black87,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  useMaterial3: true,
  fontFamily: "Montserrat",
  listTileTheme: const ListTileThemeData(
    tileColor: Colors.transparent,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 20.0,
    ),
    displayMedium: TextStyle(fontSize: 20.0),
    displaySmall: TextStyle(fontSize: 20.0),
    //
    headlineLarge:
        TextStyle(fontSize: 26, fontWeight: FontWeight.w800, height: 1.2),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
    //
    titleLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
    titleSmall: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
    //
    bodyLarge: TextStyle(
      fontSize: 18,
      color: Colors.black87,
    ),
    bodyMedium: TextStyle(
      fontSize: 18,
      color: Colors.black87,
    ),
    bodySmall: TextStyle(
      fontSize: 17,
      color: Colors.black87,
    ),
    //
    labelLarge: TextStyle(fontSize: 20.0),
    labelMedium: TextStyle(fontSize: 20.0),
    labelSmall: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color.fromRGBO(60, 105, 220, 1),
      textStyle: const TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      foregroundColor: Colors.white,
    ),
  ),
);
