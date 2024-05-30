part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationsLoaded extends LocationState {
  final List<String> locations;
  final String selectedLocation;
  LocationsLoaded(this.locations, this.selectedLocation);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
