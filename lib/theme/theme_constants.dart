import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: Colors.black,
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.5)),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFE0F7FA),
    ));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: const TextTheme(
        titleLarge: TextStyle(
            color: Colors.white,
            fontFamily: "Poppins",
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.5)),
    colorScheme: const ColorScheme.dark(primary: Color(0xFF242A32)));
