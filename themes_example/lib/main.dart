import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/bloc/themes_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Light/Dark Mode',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: BlocProvider(
          create: (context) => ThemeBloc(),
          child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
            return MaterialApp(
                title: 'Flutter Demo',
                theme: state.themeData, // Apply the theme data from ThemeBloc
                home: MyHomePage());
          }),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggle Theme Example'),
      ),
      body: Center(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            final primaryColor = Theme.of(context).primaryColor;
            return Column(children: [
              SwitchListTile(
                title: const Text('Toggle Light/Dark Mode'),
                secondary: const Icon(Icons.dark_mode),
                value: state.themeMode ==
                    ThemeMode
                        .dark, // Correctly check against the themeMode in state
                onChanged: (bool value) {
                  context
                      .read<ThemeBloc>()
                      .add(ToggleThemeEvent()); // This will toggle the theme
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
                onPressed: () {
                  // Add button logic here
                },
                child: const Text('I use the primary color!',
                    style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add button logic here
                },
                child: Text('Button 2'),
              ),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Input Field',
                ),
              ),
            ]);
          },
        ),
      ),
    );
  }
}
