import 'package:flutter/material.dart';

const _primary = Color(0xFF5751B5);
const _onPrimary = Color(0xFFFFFFFF);
const _primaryContainer = Color(0xFFE4DFFF);
const _onPrimaryContainer = Color(0xFF10006A);
const _secondary = Color(0xFF5E5C72);
const _onSecondary = Color(0xFFFFFFFF);
const _secondaryContainer = Color(0xFFE4E0F9);
const _onSecondaryContainer = Color(0xFF1A1A2C);
const _tertiary = Color(0xFF7A5267);
const _onTertiary = Color(0xFFFFFFFF);
const _tertiaryContainer = Color(0xFFFFD8EB);
const _onTertiaryContainer = Color(0xFF2F1123);
const _error = Color(0xFFBA1B1B);
const _errorContainer = Color(0xFFFFDAD4);
const _onError = Color(0xFFFFFFFF);
const _onErrorContainer = Color(0xFF410001);
const _background = Color(0xFFFFFBFF);
const _onBackground = Color(0xFF1C1B1F);
const _surface = Color(0xFFFFFBFF);
const _onSurface = Color(0xFF1C1B1F);

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme(
    primary: _primary,
    onPrimary: _onPrimary,
    primaryContainer: _primaryContainer,
    onPrimaryContainer: _onPrimaryContainer,
    secondary: _secondary,
    onSecondary: _onSecondary,
    secondaryContainer: _secondaryContainer,
    onSecondaryContainer: _onSecondaryContainer,
    tertiary: _tertiary,
    onTertiary: _onTertiary,
    tertiaryContainer: _tertiaryContainer,
    onTertiaryContainer: _onTertiaryContainer,
    error: _error,
    onError: _onError,
    errorContainer: _errorContainer,
    onErrorContainer: _onErrorContainer,
    background: _background,
    onBackground: _onBackground,
    surface: _surface,
    onSurface: _onSurface,
    brightness: Brightness.light,
  ),
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      fontFamily: 'Oswald',
      color: _primary,
      height: 1.22,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      fontFamily: 'Oswald',
      color: _primary,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w300,
      fontFamily: 'Roboto',
      color: _primary,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      fontFamily: 'Oswald',
      color: _primary,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.1,
      fontFamily: 'Oswald',
      color: _primary,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Oswald',
      color: _secondary,
    ),
    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
      color: _onPrimary,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      color: _onSecondaryContainer,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      fontFamily: 'Roboto',
      color: _onBackground,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      fontFamily: 'Roboto',
      color: _onBackground,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Roboto',
      color: _onBackground,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(_secondaryContainer),
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 36,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(horizontal: 15),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: _primary,
    size: 22,
  ),
  primarySwatch: Colors.deepPurple,
);
