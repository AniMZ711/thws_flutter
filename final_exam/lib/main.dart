import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skylinq/bloc/forecast/forecast_bloc.dart';
import 'package:skylinq/bloc/location/location_bloc.dart';
import 'package:skylinq/bloc/theme/theme_bloc.dart';
import 'package:skylinq/ui/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (context) => LocationBloc(),
        ),
        BlocProvider<ForecastBloc>(
          create: (context) => ForecastBloc(
              BlocProvider.of<LocationBloc>(context, listen: false)),
        ),
        BlocProvider<ThemeBloc>(
          create: (context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: state.themeData, // Apply the theme data from ThemeBloc
            home: HomePage(),
          );
        },
      ),
    );
  }
}
