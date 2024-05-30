import 'package:flutter/material.dart';
import 'package:skylinq/bloc/theme/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skylinq/ui/pages/locations_page.dart';
import 'package:skylinq/ui/pages/settings_page.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool isDarkModeEnabled = false; //default

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 200,
                  color: Colors.blue[700],
                  padding: const EdgeInsets.all(16.0),
                  alignment: Alignment.bottomCenter,
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.sunny),
                      Text(
                        'SKYLINQ WEATHER',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on_sharp),
                  title: const Text('Locations'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeLocationPage()));
                  },
                ),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return SwitchListTile(
                      title: const Text('Light/Dark Mode'),
                      secondary: const Icon(Icons.dark_mode),
                      value: state.themeMode ==
                          ThemeMode.dark, // Adjusted to use ThemeMode from Bloc
                      inactiveThumbColor: Colors.blue[700],
                      activeColor: Colors.white,
                      activeTrackColor: Colors.blue[700],
                      onChanged: (bool value) {
                        context.read<ThemeBloc>().add(ToggleThemeEvent());
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.settings),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()));
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            child: const Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
