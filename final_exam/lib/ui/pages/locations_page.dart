import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skylinq/bloc/location/location_bloc.dart';

class ChangeLocationPage extends StatefulWidget {
  @override
  State<ChangeLocationPage> createState() => _ChangeLocationPageState();
}

class _ChangeLocationPageState extends State<ChangeLocationPage> {
  final TextEditingController _controller = TextEditingController();
  String _lastDeletedLocation = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          context.read<LocationBloc>().add(AddLocation(_lastDeletedLocation));
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Location"),
      ),
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationsLoaded) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Add new location',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      context
                          .read<LocationBloc>()
                          .add(AddLocation(_controller.text.trim()));
                      _controller.clear();
                    }
                  },
                  child: const Text('Add Location'),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.locations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(state.locations[index]),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _lastDeletedLocation = state.locations[index];
                                context.read<LocationBloc>().add(
                                      DeleteLocation(state.locations[index]),
                                    );
                                showToast(
                                  context,
                                  "Location ${state.locations[index]} deleted",
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          context.read<LocationBloc>().add(
                                SelectLocation(state.locations[index]),
                              );
                          Navigator.pop(context);
                          showToast(
                            context,
                            "Location changed to ${state.locations[index]}",
                          );
                        },
                        selected:
                            state.locations[index] == state.selectedLocation,
                      );
                    },
                  ),
                )
              ],
            );
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
