import 'package:flutter/material.dart';

const Color thws = Color.fromARGB(255, 255, 106, 0);

final ColorScheme myCustomColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: const Color.fromARGB(255, 7, 36, 72), // Example primary color
  onPrimary: Colors.white, // Text/icon color on top of primary
  secondary: const Color.fromARGB(255, 84, 210, 210), // Example secondary color
  onSecondary: Colors.black, // Text/icon color on top of secondary
  error: const Color.fromARGB(255, 255, 97, 80), // Example error color
  onError: Colors.white, // Text/icon color on top of error
  background: Colors.grey[200]!, // Example background color
  onBackground: Colors.black, // Text/icon color on top of background
  surface: Colors.white, // Example surface color
  onSurface: Colors.black, // Text/icon color on top of surface
);

final ThemeData myCustomTheme = ThemeData(
  useMaterial3: true, // Set to true if you want to use Material 3 features
  colorScheme: myCustomColorScheme,
  // Add any other theme customization here
);
