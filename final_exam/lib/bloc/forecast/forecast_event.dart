part of 'forecast_bloc.dart';

sealed class ForecastEvent {}

class GetForecast extends ForecastEvent {
  final String city;
  final num days;

  GetForecast(this.city, this.days);
}
