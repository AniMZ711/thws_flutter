import 'package:flutter/material.dart';

// you can use https://material-foundation.github.io/material-theme-builder/ to build your theme
class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue, // This should be the color you see
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.blue,
    ),
    // Add other theme properties
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: const Color.fromARGB(255, 50, 29, 85),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.deepPurple,
    ),
    // Add other theme properties
  );
}
