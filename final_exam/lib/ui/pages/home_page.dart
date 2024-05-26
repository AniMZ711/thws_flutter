import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skylinq/bloc/location/location_bloc.dart';
import 'package:skylinq/bloc/forecast/forecast_bloc.dart';
import 'package:skylinq/ui/components/current_weather_card.dart';
import 'package:skylinq/ui/components/drawer/custom_drawer.dart';
import 'package:skylinq/ui/components/scrollbar/forecast_scroll.dart';
import 'package:skylinq/ui/components/weekforecast/week_forecast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    // Listen to changes in the location and load weather accordingly
    context.read<LocationBloc>().stream.listen((locationState) {
      if (locationState is LocationsLoaded) {
        _loadWeather(locationState.selectedLocation);
      }
    });

    // Ensure the initial load uses the last selected or default location
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.read<LocationBloc>().state is LocationsLoaded) {
        var initialLocation =
            (context.read<LocationBloc>().state as LocationsLoaded)
                .selectedLocation;
        _loadWeather(initialLocation);
      } else {
        context.read<LocationBloc>().add(LoadLocations());
      }
    });
  }

  void _loadWeather(String location) {
    context.read<ForecastBloc>().add(GetForecast(location, 7));
  }

  Future<void> _refreshData() async {
    final selectedLocation =
        (context.read<LocationBloc>().state as LocationsLoaded)
            .selectedLocation;
    _loadWeather(selectedLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SKYLINQ'),
        ),
        drawer: CustomDrawer(),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Center(
            child: BlocBuilder<ForecastBloc, ForecastState>(
              builder: (context, state) {
                if (state is ForecastLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ForecastLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        WeatherCard(
                            key: ValueKey(state.currentLocation),
                            forecast: state.forecast),
                        Container(
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          height: 130,
                          child: ForecastScroll(forecastData: state.forecast),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          width: double.infinity,
                          child: LayoutBuilder(
                            builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return WeekForecast(forecastData: state.forecast);
                            },
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  );
                } else if (state is ForecastError) {
                  return Text('Error: ${state.message}');
                }
                return const Text("No data available.");
              },
            ),
          ),
        ));
  }
}
