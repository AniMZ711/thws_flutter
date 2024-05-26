import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Ensure this import is added

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationsLoaded([], 'Default Location')) {
    on<LoadLocations>(_onLoadLocations);
    on<AddLocation>(_onAddLocation);
    on<SelectLocation>(_onSelectLocation);
    on<DeleteLocation>(_onDeleteLocation);

    add(LoadLocations()); // Initial load of locations from SharedPreferences
  }

  Future<void> _onLoadLocations(
      LoadLocations event, Emitter<LocationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> locations =
        prefs.getStringList('locations') ?? ['Default Location'];
    String selected = prefs.getString('selectedLocation') ?? locations[0];
    emit(LocationsLoaded(locations, selected));
  }

  Future<void> _onAddLocation(
      AddLocation event, Emitter<LocationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> locations = prefs.getStringList('locations') ?? [];
    if (!locations.contains(event.location)) {
      locations.add(event.location);
      await prefs.setStringList('locations', locations);
    }
    emit(LocationsLoaded(locations, event.location));
  }

  Future<void> _onSelectLocation(
      SelectLocation event, Emitter<LocationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLocation', event.location);
    List<String> locations = prefs.getStringList('locations') ?? [];
    emit(LocationsLoaded(locations, event.location));
  }

  Future<void> _onDeleteLocation(
      DeleteLocation event, Emitter<LocationState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> locations = prefs.getStringList('locations') ?? [];
    locations.remove(event.location);
    await prefs.setStringList('locations', locations);
    emit(LocationsLoaded(locations, locations[0]));
  }
}
