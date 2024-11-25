import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  LatLng?
      _selectedPosition; // Variable to store the selected position on the map

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
        actions: [
          if (_selectedPosition != null)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                // Return the selected location to the previous screen
                Navigator.pop(context, _selectedPosition);
              },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(21.543333, 39.172778), // Default Jeddah location
          zoom: 14.0,
        ),
        onTap: (LatLng position) {
          // Update the selected position when the user taps on the map
          setState(() {
            _selectedPosition = position;
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
