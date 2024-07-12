import 'package:flutter/material.dart';

class DefaultTheme {
  static const hintColor = Colors.white;
  static const primaryColor = Colors.orange;
  static const primaryColorDark = Colors.black26;
  static Color canvasColor = Colors.black.withOpacity(0.4);
  static ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple, brightness: Brightness.light);
}

class DarkTheme {
  static const hintColor = Colors.white;
  static const primaryColor = Colors.orange;
  static const primaryColorDark = Colors.black26;
  static Color canvasColor = Colors.black.withOpacity(0.4);
  static ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple, brightness: Brightness.dark);
}

class DefaultStatusBarStyle {
  // static const statusBarColor = Colors.white;
  static const statusBarColor = Colors.transparent;
  static const statusBarIconBrightness = Brightness.dark;
}
