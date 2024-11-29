import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:green_oil_seekers/schedule_screen/orders_list/orders_list.dart';
import 'package:green_oil_seekers/models/offer.dart';

class OrderSwitcher extends StatefulWidget {
  const OrderSwitcher({super.key});

  @override
  State<OrderSwitcher> createState() {
    return _OrderSwitcherState();
  }
}

class _OrderSwitcherState extends State<OrderSwitcher> {
  final List<Offer> _ongoingOrders = [];
  final List<Offer> _historyOrders = [];
  int selectedIndex = 0;
  var _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Fetch requests initially
    getUserRequests();

    // Set up a timer to call getUserRequests every 2 minutes
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      getUserRequests();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  // get user requests from Firebase Realtime Database
  void getUserRequests() async {
    try {
      final seekerEmail = FirebaseAuth.instance.currentUser?.email;

      if (seekerEmail != null) {
        final databaseRef = FirebaseDatabase.instance.ref('requests');
        final snapshot = await databaseRef.get();

        if (snapshot.exists) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);

          // Clear the lists before adding new data
          _ongoingOrders.clear();
          _historyOrders.clear();

          data.forEach((userId, userRequests) {
            final userRequestMap =
                Map<String, dynamic>.from(userRequests as Map);
            userRequestMap.forEach((requestId, requestData) {
              final request = Map<String, dynamic>.from(requestData);

              if (request['seeker Email']?.toString().toLowerCase() ==
                  seekerEmail.toLowerCase()) {
                // Parse Provider Info
                final providerData =
                    Map<String, dynamic>.from(request['Provider Info']);

                final CustomerInfo customerInfo = CustomerInfo(
                  name: providerData['Name']?.toString() ?? 'Unknown',
                  companyName:
                      providerData['Company Name']?.toString() ?? 'Unknown',
                  phoneNumber: providerData['Phone']?.toString() ?? '',
                  image: providerData['image_url']?.toString() ?? '',
                  providerEmail: providerData['Email']?.toString() ?? '',
                  seekerEmail: seekerEmail,
                );

                // Parse request data
                final double oilQuantity =
                    double.parse(request['quantity'].toString());
                final double oilPrice =
                    double.parse(request['oil Price'].toString());
                final String oilType =
                    request['oil Type'].toString().toLowerCase();

                // Parse orderStatus dynamically from the request
                final String status =
                    request['order Status']?.toString().toLowerCase() ??
                        'pending';

                final OrderStatus orderStatus = OrderStatus.values.firstWhere(
                  (e) => e.toString().split('.').last.toLowerCase() == status,
                  orElse: () =>
                      OrderStatus.pending, // Default to pending if not found
                );

                final Offer offer = Offer(
                  orderID: requestId,
                  oilType: OilType.values.firstWhere(
                    (e) =>
                        e.toString().split('.').last.toLowerCase() == oilType,
                    orElse: () => OilType.cookingOil,
                  ),
                  oilQuantity: oilQuantity,
                  oilPrice: oilPrice,
                  arrivalDate: DateTime.parse(request['arrival Date']),
                  orderStatus:
                      orderStatus, // Use the dynamically parsed orderStatus
                  location: Location(
                    latitude: double.parse(
                        request['location']['latitude'].toString()),
                    longitude: double.parse(
                        request['location']['longitude'].toString()),
                  ),
                  customerInfo: customerInfo,
                );

                // Add to the correct list based on the order status
                if (offer.orderStatus == OrderStatus.completed ||
                    offer.orderStatus == OrderStatus.cancelled) {
                  _historyOrders.add(offer);
                } else {
                  _ongoingOrders.add(offer);
                }
              }
            });
          });
        }

        setState(() {
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred while fetching orders: $error",
            ),
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_isLoading) {
      content = const Center(child: CircularProgressIndicator());
    } else if (selectedIndex == 0 && _ongoingOrders.isEmpty) {
      // Show specific message for Ongoing tab
      content = Center(
        child: Text(
          'No ongoing orders.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      );
    } else if (selectedIndex == 1 && _historyOrders.isEmpty) {
      // Show specific message for History tab
      content = Center(
          child: Text(
        'No completed or cancelled orders.',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ));
    } else {
      // Show the corresponding list based on the selected tab
      content = selectedIndex == 0
          ? OrdersList(offers: _ongoingOrders)
          : OrdersList(offers: _historyOrders);
    }

    return Column(
      children: [
        // Use a Stack to overlay buttons on the same vertical level
        Stack(
          alignment: Alignment.center,
          children: [
            // Unselected background layer (visible part of the unselected button)
            Positioned(
              child: Container(
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(94, 36, 165, 79),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Change to "Ongoing" only if it's unselected
                        if (selectedIndex != 0) {
                          setState(() {
                            selectedIndex = 0;
                          });
                        }
                      },
                      child: Text(
                        'Ongoing',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Change to "History" only if it's unselected
                        if (selectedIndex != 1) {
                          setState(() {
                            selectedIndex = 1;
                          });
                        }
                      },
                      child: Text(
                        'History',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Selected button overlay
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              left: selectedIndex == 0
                  ? 0
                  : 175, // Adjust the position based on the selected button
              child: Container(
                width: 175,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Center(
                  child: Text(
                    selectedIndex == 0 ? 'Ongoing' : 'History',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Wrap Expanded widget in Flexible or wrap the entire Column with Expanded
        Expanded(
          child: content,
        ),
      ],
    );
  }
}
