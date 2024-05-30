part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LoadLocations extends LocationEvent {}

class AddLocation extends LocationEvent {
  final String location;
  const AddLocation(this.location);
}

class SelectLocation extends LocationEvent {
  final String location;
  const SelectLocation(this.location);
}

class DeleteLocation extends LocationEvent {
  final String location;
  const DeleteLocation(this.location);
}
