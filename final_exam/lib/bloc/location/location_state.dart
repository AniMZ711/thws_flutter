part of 'location_bloc.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {}

// class LocationLoaded extends LocationState {
//   final String
//       currentLocation;

//   LocationLoaded(this.currentLocation);
// }

class LocationsLoaded extends LocationState {
  final List<String> locations;
  final String selectedLocation;
  LocationsLoaded(this.locations, this.selectedLocation);
}

class LocationError extends LocationState {
  final String message;

  LocationError(this.message);
}
