import 'package:flutter/material.dart';

class AppTheme {
  static const Color statusOk = Color(0xFFA8D5BA);
  static const Color statusAlert = Color(0xFFFFD180);
  static const Color statusDanger = Color(0xFFF2A6A6);

  static const Color primaryGreen = Color(0xFF5F8C61);
  static const Color backgroundLight = Color(0xFFF7F9F7);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: backgroundLight,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        brightness: Brightness.light,
        surface: backgroundLight,
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: backgroundLight),
        titleTextStyle: TextStyle(
          color: Colors.black87,
          fontSize: 22,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),

      cardTheme: CardThemeData(
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.05),
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(color: Colors.black54),
      ),
    );
  }
}
