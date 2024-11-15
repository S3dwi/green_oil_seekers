import 'package:flutter/material.dart';

import 'order_summary_screen.dart';

class OfferDetailScreen extends StatelessWidget {
  final Map<String, dynamic> offerDetails;

  const OfferDetailScreen({Key? key, required this.offerDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final double oilPrice = offerDetails['price'];
    final int qtyOil = offerDetails['quantity'];
    final String companyName = offerDetails['company'];
    final String oilType = offerDetails['oilType'];
    final String pickupDate = offerDetails['pickupDate'];
    final String customerLocation =
        'Jeddah - Alrabwah 23553, Asbat Bin Nasr St.';

    return Scaffold(
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: colorScheme.onSecondary,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Image.asset(
                      offerDetails['image'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      companyName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Quantity: $qtyOil L'),
                            Text('Price per liter: $oilPrice SAR'),
                            Text('Distance: ${offerDetails['distance']} KM'),
                            Text('Pickup Date: $pickupDate'),
                          ],
                        ),
                        Text(
                          '${(qtyOil * oilPrice).toStringAsFixed(2)} SAR',
                          style: TextStyle(
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSummaryScreen(
                      companyName: companyName,
                      oilType: oilType,
                      qtyOil: qtyOil,
                      oilPrice: oilPrice,
                      customerLocation: customerLocation,
                      pickupDate: pickupDate,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: colorScheme.onPrimary,
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'CHOOSE',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
