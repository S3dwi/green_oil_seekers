import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:green_oil_seekers/order_flow/step_progress_indicator.dart';
import 'package:green_oil_seekers/order_flow/offers_list/offers_list.dart';
import 'package:green_oil_seekers/order_flow/order_summery_screen.dart';
import 'package:green_oil_seekers/primary_button.dart';
import 'package:green_oil_seekers/models/offer.dart';

class PickOfferScreen extends StatefulWidget {
  final List<String> selectedOilTypes;
  final double minQuantity;
  final double maxQuantity;
  final double minPrice;
  final double maxPrice;

  const PickOfferScreen({
    super.key,
    required this.selectedOilTypes,
    required this.minQuantity,
    required this.maxQuantity,
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  State<StatefulWidget> createState() {
    return _PickOfferScreenState();
  }
}

class _PickOfferScreenState extends State<PickOfferScreen> {
  final List<Offer> offers = [];
  int? selectedOfferIndex;
  var _isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Fetch requests initially
    gitOffers();
    // Set up a timer to call getUserRequests every 1 minute
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      gitOffers();
    });
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    _timer?.cancel();
    super.dispose();
  }

  void selectOffer(int index) {
    setState(() {
      selectedOfferIndex = index;
    });
  }

  void gitOffers() async {
    try {
      // Fetch all requests from the 'requests' node
      final databaseRef = FirebaseDatabase.instance.ref('requests');
      final snapshot = await databaseRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);
        final List<Offer> fetchedOffers = [];

        data.forEach((userId, userRequests) {
          final userRequestMap = Map<String, dynamic>.from(userRequests as Map);
          userRequestMap.forEach((requestId, requestData) {
            final request = Map<String, dynamic>.from(requestData);

            // Check if the order status is pending
            if (request['order Status']?.toString().toLowerCase() ==
                'pending') {
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
                seekerEmail: 'default_email@example.com',
              );

              // Parse request data
              final double oilQuantity =
                  double.parse(request['quantity'].toString());
              final double oilPrice =
                  double.parse(request['oil Price'].toString());
              final String oilType =
                  request['oil Type'].toString().toLowerCase();

              // Check if the request matches the filters
              if (widget.selectedOilTypes
                      .map((e) => e.toLowerCase())
                      .contains(oilType) &&
                  oilQuantity >= widget.minQuantity &&
                  oilQuantity <= widget.maxQuantity &&
                  oilPrice >= widget.minPrice &&
                  oilPrice <= widget.maxPrice) {
                // Create Offer object
                fetchedOffers.add(
                  Offer(
                    orderID: requestId,
                    oilType: OilType.values.firstWhere(
                      (e) =>
                          e.toString().split('.').last.toLowerCase() == oilType,
                      orElse: () => OilType.cookingOil,
                    ),
                    oilQuantity: oilQuantity,
                    oilPrice: oilPrice,
                    arrivalDate: DateTime.parse(request['arrival Date']),
                    orderStatus: OrderStatus.accepted,
                    location: Location(
                      city: request['location']['city'].toString(),
                      latitude: double.parse(
                          request['location']['latitude'].toString()),
                      longitude: double.parse(
                          request['location']['longitude'].toString()),
                    ),
                    customerInfo: customerInfo,
                  ),
                );
              }
            }
          });
        });

        // Update the offers state
        setState(() {
          offers.clear();
          offers.addAll(fetchedOffers);
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
              "An error occurred while fetching offers: $error",
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
      content = Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 278.5,
          ),
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      );
    } else if (offers.isEmpty) {
      content = Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 282,
          ),
          child: Text(
            'No offers found that match the filters',
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20,
            ),
          ),
        ),
      );
    } else {
      content = Expanded(
        child: OffersList(
          offers: offers,
          selectedOfferIndex: selectedOfferIndex,
          onSelect: selectOffer,
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false, // Avoid bottom inset adjustments
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 37),
            Text(
              "Choose Offer",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: StepProgressIndicator(
              currentStep: 1,
              totalSteps: 4,
            ),
          ),
          content,
          const SizedBox(height: 28),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                onPressed: selectedOfferIndex == null
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Please select an offer before proceeding!'),
                          ),
                        );
                      }
                    : () {
                        final selectedOffer = offers[selectedOfferIndex!];
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderSummeryScreen(
                              offer: selectedOffer,
                            ),
                          ),
                        );
                      },
                backgroundColor: selectedOfferIndex == null
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).colorScheme.primary,
                label: 'CHOOSE',
                vertical: 13,
                horizontal: 129.9,
              ),
            ],
          ),
          const SizedBox(height: 38),
        ],
      ),
    );
  }
}
