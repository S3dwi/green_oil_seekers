import 'package:flutter/material.dart';

import '../primary_button.dart';
import 'offer_detail_screen.dart';
import 'order_summary_screen.dart';

class PickOfferScreen extends StatefulWidget {
  const PickOfferScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PickOfferScreenState();
  }
}

class _PickOfferScreenState extends State<PickOfferScreen> {
  int? selectedOfferIndex;

  final List<Map<String, dynamic>> offers = [
    {
      'oilType': 'Cooking Oil',
      'quantity': 700,
      'price': 3.0,
      'distance': 20,
      'pickupDate': '10 OCT',
      'image': 'assets/images/JanBurgerLogo.png',
      'company': 'JAN BURGER',
    },
    {
      'oilType': 'Cooking Oil',
      'quantity': 540,
      'price': 4.0,
      'distance': 30,
      'pickupDate': '10 OCT',
      'image': 'assets/images/AlbaikLogo.png',
      'company': 'ALBAIK CO.',
    },
    {
      'oilType': 'Cooking Oil',
      'quantity': 300,
      'price': 5.0,
      'distance': 40,
      'pickupDate': '10 OCT',
      'image': 'assets/images/AlbaikLogo.png',
      'company': 'ALBAIK CO.',
    },
  ];

  void _onChooseOffer() {
    if (selectedOfferIndex != null) {
      final selectedOffer = offers[selectedOfferIndex!];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderSummaryScreen(
            companyName: selectedOffer['company'],
            oilType: selectedOffer['oilType'],
            qtyOil: selectedOffer['quantity'],
            oilPrice: selectedOffer['price'],
            customerLocation: 'Jeddah - Alrabwah 23553, Asbat Bin Nasr St.',
            pickupDate: selectedOffer['pickupDate'],
          ),
        ),
      );
    }
  }

  void _navigateToOfferDetails(Map<String, dynamic> offer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OfferDetailsScreen(
          companyName: offer['company'],
          oilType: offer['oilType'],
          quantity: offer['quantity'],
          pricePerLiter: offer['price'],
          distance: offer['distance'],
          pickupDate: offer['pickupDate'],
          companyAddress: 'Jeddah - Alrabwah 23553, Asbat Bin Nasr St.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor:
          0.9, // Ensures the modal height doesn't occupy the full screen
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Offers',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: offers.length,
                    separatorBuilder: (context, index) => Divider(
                      color: Theme.of(context).disabledColor,
                      thickness: 0.5,
                    ),
                    itemBuilder: (context, index) {
                      final offer = offers[index];
                      final finalPrice = offer['quantity'] * offer['price'];

                      return GestureDetector(
                        onTap: () => setState(() {
                          selectedOfferIndex = index;
                        }),
                        child: Card(
                          color: Theme.of(context).colorScheme.onPrimary,
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Stack(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () =>
                                          _navigateToOfferDetails(offer),
                                      child: Image.asset(
                                        offer['image'],
                                        width: 80,
                                        height: 90,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () =>
                                            _navigateToOfferDetails(offer),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              offer['oilType'],
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                                'Quantity: ${offer['quantity']} L'),
                                            Text(
                                                'Price per liter: ${offer['price']} SAR'),
                                            Text(
                                                'Distance: ${offer['distance']} KM'),
                                            Text(
                                                'Pickup Date: ${offer['pickupDate']}'),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Icon(
                                    selectedOfferIndex == index
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_unchecked,
                                    color: selectedOfferIndex == index
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).disabledColor,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Text(
                                    '${finalPrice.toStringAsFixed(0)} SAR',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: PrimaryButton(
                    onPressed:
                        selectedOfferIndex != null ? _onChooseOffer : () {},
                    backgroundColor: selectedOfferIndex != null
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).disabledColor,
                    label: 'CHOOSE',
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    verticalPadding: 18.0,
                    horizontalPadding: 139.0,
                    isEnabled: selectedOfferIndex != null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
