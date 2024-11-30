import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_oil_seekers/models/offer.dart'; // Assuming Location class is defined here

class DisplayLocation extends StatefulWidget {
  const DisplayLocation({
    super.key,
    required this.location,
  });

  final Location location;

  @override
  State<StatefulWidget> createState() {
    return _DisplayLocationState();
  }
}

class _DisplayLocationState extends State<DisplayLocation> {
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initializeMarker();
  }

  void _initializeMarker() {
    // Convert the Location object to LatLng
    LatLng position =
        LatLng(widget.location.latitude, widget.location.longitude);

    // Add a marker at the specified position
    _markers.add(
      Marker(
        markerId: const MarkerId('companyLocation'),
        position: position,
        infoWindow: const InfoWindow(
            title: 'Company Location'), // Optional: Customize info window
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Camera position centered on the provided location
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 16.0,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Location'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: _markers,
        zoomControlsEnabled: false, // Optional: Disable zoom controls
        onTap: null, // Disables changing the marker location
      ),
    );
  }
}
