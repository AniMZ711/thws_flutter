import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

import './screens/category_screen.dart';

main() {
  Logger.level = Level.debug;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: CategoryScreen(),
    );
  }
}
