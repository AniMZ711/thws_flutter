part of 'forecast_bloc.dart';

sealed class ForecastState {}

final class ForecastInitial extends ForecastState {}

final class ForecastLoading extends ForecastState {}

final class ForecastLoaded extends ForecastState {
  final Forecast forecast;
  final String currentLocation;
  ForecastLoaded(this.forecast, this.currentLocation);
}

final class ForecastError extends ForecastState {
  final String message;

  ForecastError(this.message);
}

final class ForecastEmpty extends ForecastState {}
