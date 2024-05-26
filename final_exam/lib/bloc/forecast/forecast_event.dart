part of 'forecast_bloc.dart';

@immutable
sealed class ForecastEvent {}

class GetForecast extends ForecastEvent {
  final String city;
  final num days;

  GetForecast(this.city, this.days);
}

class Get3DayForecast extends ForecastEvent {
  final String city;
  final days = 3;

  Get3DayForecast(this.city, days);
}

class Get7DayForecast extends ForecastEvent {
  final String city;
  final days = 7;

  Get7DayForecast(this.city, days);
}
