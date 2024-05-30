import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue[700],
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Define other light theme properties as needed
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blueGrey,
    primaryColor: Colors.blue[700],
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // Define other dark theme properties as needed
  );
}
