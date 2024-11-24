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
  final List<Offer> offers = [
    Offer(
      orderID: 'DS032402',
      oilType: OilType.cookingOil,
      oilQuantity: 10.5,
      oilPrice: 44,
      arrivalDate: DateTime.now(),
      orderStatus: OrderStatus.accepted,
      location: Location(
        city: 'Jeddah',
        latitude: 21.735611,
        longitude: 39.283458,
      ),
      customerInfo: CustomerInfo(
        name: 'Abdulaziz',
        companyName: 'ALBAIK',
        phoneNumber: '0505406459',
        image: 'assets/images/home_img.png',
        providerEmail: 'provider@example.com',
        seekerEmail: 'seeker@example.com',
      ),
    ),
    Offer(
      orderID: 'DS032403',
      oilType: OilType.motorOil,
      oilQuantity: 20.0,
      oilPrice: 80,
      arrivalDate: DateTime.now().add(const Duration(days: 1)),
      orderStatus: OrderStatus.pending,
      location: Location(
        city: 'Riyadh',
        latitude: 24.713552,
        longitude: 46.675297,
      ),
      customerInfo: CustomerInfo(
        name: 'Abdulaziz',
        companyName: 'ALBAIK',
        phoneNumber: '0505406459',
        image: 'assets/images/home_img.png',
        providerEmail: 'provider@example.com',
        seekerEmail: 'seeker@example.com',
      ),
    ),
  ];
  int? selectedOfferIndex;

  void selectOffer(int index) {
    setState(() {
      selectedOfferIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(
            child: OffersList(
              offers: offers,
              selectedOfferIndex: selectedOfferIndex,
              onSelect: selectOffer,
            ),
          ),
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
