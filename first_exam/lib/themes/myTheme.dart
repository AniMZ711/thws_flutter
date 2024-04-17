
import 'package:flutter/material.dart';

const Color thws = Color.fromARGB(255, 255, 106, 0);

final ColorScheme myCustomColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 23, 60, 105), // Example primary color
  onPrimary: Colors.white, // Text/icon color on top of primary
  secondary: thws, // Example secondary color
  onSecondary: Colors.black, // Text/icon color on top of secondary
  error: Colors.red, // Example error color
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

