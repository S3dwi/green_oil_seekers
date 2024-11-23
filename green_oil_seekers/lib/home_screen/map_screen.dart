import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedPosition; // Store the selected position

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        actions: [
          if (_selectedPosition != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Return the selected position to the previous screen
                Navigator.pop(context, _selectedPosition);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.543333, 39.172778), // Default Jeddah
          zoom: 14.0,
        ),
        onTap: (position) {
          setState(() {
            _selectedPosition = position; // Save tapped position
          });
        },
        markers: _selectedPosition != null
            ? {
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: _selectedPosition!,
                  infoWindow: const InfoWindow(title: 'Selected Location'),
                ),
              }
            : {},
      ),
    );
  }
}
