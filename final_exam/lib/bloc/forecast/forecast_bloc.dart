import 'package:bloc/bloc.dart';
import 'package:skylinq/bloc/location/location_bloc.dart';

import 'dart:async';

import 'package:skylinq/data/models/forecast.dart';
import 'package:skylinq/data/repository/weather_api.dart';

part 'forecast_event.dart';
part 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  final LocationBloc locationsBloc;

  late StreamSubscription locationSubscription;

  ForecastBloc(this.locationsBloc) : super(ForecastInitial()) {
    WeatherAPI weatherAPI = WeatherAPI();

//subscribe to location changes from location bloc
    locationSubscription = locationsBloc.stream.listen((locationState) {
      if (locationState is LocationsLoaded) {
        add(GetForecast(locationState.selectedLocation,
            7)); // when this number is changed, the number of days in the forecast are changed
      }
    });

    on<GetForecast>((event, emit) async {
      emit(ForecastLoading());
      try {
        Forecast forecast =
            await weatherAPI.getForecast(event.city, event.days);
        emit(ForecastLoaded(forecast, event.city));
      } catch (e) {
        emit(ForecastError("Failed to load weather data: $e"));
      }
    });
  }
}
