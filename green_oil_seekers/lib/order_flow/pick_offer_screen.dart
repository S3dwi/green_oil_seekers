import 'package:flutter/material.dart';

import '../primary_button.dart';
import 'offer_detail_screen.dart';
import 'order_summary_screen.dart';

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
  int? selectedOfferIndex;

  final List<Map<String, dynamic>> offers = [
    {
      'oilType': 'Cooking Oil',
      'quantity': 700,
      'price': 3.0,
      'distance': 20,
      'pickupDate': '10 OCT',
      'company': 'JAN BURGER',
      'image': 'assets/images/JanBurgerLogo.png',
    },
    {
      'oilType': 'Cooking Oil',
      'quantity': 540,
      'price': 4.0,
      'distance': 30,
      'pickupDate': '10 OCT',
      'company': 'ALBAIK CO.',
      'image': 'assets/images/AlbaikLogo.png',
    },
    {
      'oilType': 'Cooking Oil',
      'quantity': 300,
      'price': 5.0,
      'distance': 40,
      'pickupDate': '10 OCT',
      'company': 'ALBAIK CO.',
      'image': 'assets/images/AlbaikLogo.png',
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

  void _navigateToOfferDetail(Map<String, dynamic> offer) {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Offer'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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

                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedOfferIndex = index;
                    }),
                    child: Card(
                      color: Theme.of(context).colorScheme.onPrimary,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () => _navigateToOfferDetail(offer),
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
                                    onTap: () => _navigateToOfferDetail(offer),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          offer['company'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text('Quantity: ${offer['quantity']} L'),
                                        Text(
                                            'Price per liter: ${offer['price']} SAR'),
                                        Text(
                                            'Pickup Date: ${offer['pickupDate']}'),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Radio<int>(
                                value: index,
                                groupValue: selectedOfferIndex,
                                onChanged: (value) {
                                  setState(() {
                                    selectedOfferIndex = value;
                                  });
                                },
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Text(
                                '${(offer['price'] * offer['quantity']).toStringAsFixed(0)} SAR',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
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
            PrimaryButton(
              onPressed: selectedOfferIndex != null ? _onChooseOffer : (){},
              label: 'CHOOSE',
              verticalPadding: 18.0,
              horizontalPadding: 140.0,
              isEnabled: selectedOfferIndex != null,
            ),
          ],
        ),
      ),
    );
  }
}
