import 'package:flutter/material.dart';


class AppColors {
  static const Color primaryColor = Color(0xff0096FC);
  static const Color backgroundColor = Color(0xffD9E4F1);

  static const Color darkBlue = Color(0xFF0C4A6E);
  static const Color textDark = Color(0xFF0F172A);
  static const Color textGrey = Color(0xFF64748B);
  static const Color borderGrey = Color(0xFFB9C6D6);
  static const Color lightGrey = Color(0xFFF1F5F9);
  static const Color cardBackground = Color(0xFFE0E9F4);
  static const Color activeBlue = Color(0xFF0096FC);
  static const Color inactiveRed = Color(0xFFEF4444);
  static const Color orange = Color(0xFFFF9800);
  static const Color progressbarColor = Color(0xFF398FC9);
  static const Color borderColor = Color(0xFFB6B8D0);

  static const Color border = Color(0xFFA5A7B9);
  static const lightBlue = Color(0xFFE6F2FF);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(
      primary:primaryColor,
      secondary: darkBlue,
    ),
  );
}
