import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:green_oil_seekers/home_screen/last_order_button.dart';
import 'package:green_oil_seekers/home_screen/recycle_button.dart';
import 'package:green_oil_seekers/nav_bar.dart';
import 'package:green_oil_seekers/order_flow/choose_offer_screen.dart';
import 'package:green_oil_seekers/home_screen/address_selector.dart';
import 'package:green_oil_seekers/home_screen/add_address_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _selectedAddress; // Start with no address selected
  LatLng? _selectedLatLng; // Start with no location selected
  List<String> _savedAddresses =
      []; // Start with an empty list of saved addresses

  void _openAddressSelector() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return AddressSelector(
              savedAddresses: _savedAddresses,
              onAddressSelected: (address) {
                setModalState(() {
                  _selectedAddress = address;
                });
                setState(() {
                  _selectedAddress = address;
                });
                Navigator.pop(context);
              },
              onAddNewAddress: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddAddressScreen(),
                  ),
                );

                if (result != null && result is LatLng) {
                  final newAddress =
                      'Lat: ${result.latitude.toStringAsFixed(6)}, Lng: ${result.longitude.toStringAsFixed(6)}';

                  // Check for duplicates in the saved addresses
                  bool isDuplicate =
                      _savedAddresses.any((address) => address == newAddress);

                  if (!isDuplicate) {
                    setModalState(() {
                      _savedAddresses.add(newAddress);
                    });
                    setState(() {
                      _selectedAddress = newAddress;
                      _selectedLatLng = result;
                    });
                  } else {
                    // Only update the selected address
                    setState(() {
                      _selectedAddress = newAddress;
                      _selectedLatLng = result;
                    });
                  }
                }
              },
              onDeleteAddress: (address) {
                // Delete address and update state
                setModalState(() {
                  _savedAddresses.remove(address);
                });
                setState(() {
                  if (_selectedAddress == address) {
                    _selectedAddress =
                        null; // Clear selected address if deleted
                  }
                });
              },
            );
          },
        );
      },
    );
  }

  void orderFlow(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChooseOfferScreen(),
      ),
    );
  }

  void lastOrder(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NavBar(
          wantedPage: 1,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 320,
              child: Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/home_img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Google Map
                  Visibility(
                    visible: _selectedLatLng != null,
                    child: Positioned.fill(
                      child: Opacity(
                        opacity: 0.0,
                        child: GoogleMap(
                          initialCameraPosition: const CameraPosition(
                            target: LatLng(
                                21.543333, 39.172778), // Default location
                            zoom: 14.0,
                          ),
                          markers: _selectedLatLng != null
                              ? {
                                  Marker(
                                    markerId:
                                        const MarkerId('selectedLocation'),
                                    position: _selectedLatLng!,
                                    infoWindow: const InfoWindow(
                                        title: 'Selected Location'),
                                  ),
                                }
                              : {},
                        ),
                      ),
                    ),
                  ),
                  // Overlay Text
                  Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Be Recycled',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Help the planet & enjoy \nvaluable benefits!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _selectedAddress ?? 'No address selected',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: _openAddressSelector,
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).shadowColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: RecycleButton(
                orderFlow: () {
                  orderFlow(context);
                },
              ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: LastOrderButton(
                lastOrder: () {
                  lastOrder(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'From Waste to\n',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        TextSpan(
                          text: 'Green ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: 'Solutions',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We are a company that facilitates\n'
                    'the exchange of used oil between\n'
                    'companies and individuals.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add contact us action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        fixedSize: const Size(125, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
