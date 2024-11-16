import 'package:flutter/material.dart';

import 'order_summary_screen.dart';

class OfferDetailsScreen extends StatelessWidget {
  final String companyName;
  final String oilType;
  final int quantity;
  final double pricePerLiter;
  final int distance;
  final String pickupDate;
  final String companyAddress;

  const OfferDetailsScreen({
    super.key,
    required this.companyName,
    required this.oilType,
    required this.quantity,
    required this.pricePerLiter,
    required this.distance,
    required this.pickupDate,
    required this.companyAddress,
  });

  String _getCompanyLogoPath(String companyName) {
    const companyLogos = {
      'ALBAIK CO.': 'assets/images/AlbaikLogo.png',
      'JAN BURGER': 'assets/images/JanBurgerLogo.png',
    };
    return companyLogos[companyName] ?? 'assets/images/default_logo.png';
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = (quantity * pricePerLiter).toStringAsFixed(0);

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
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Image.asset(
                            _getCompanyLogoPath(companyName),
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            companyName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      oilType,
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Quantity: $quantity L'),
                    Text('Price per liter: $pricePerLiter SAR'),
                    Text('Distance: $distance KM'),
                    Text('Pickup Date: $pickupDate'),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'SAR $totalPrice',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Contact Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact $companyName',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildContactIconButton(Icons.phone),
                    _buildContactIconButton(Icons.email),
                    _buildContactIconButton(Icons.message),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Company Location Section
            const Text(
              'Company Location',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        companyAddress,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.directions),
                      onPressed: () {
                        // Directions functionality here
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Choose Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderSummaryScreen(
                      companyName: companyName,
                      oilType: oilType,
                      qtyOil: quantity,
                      oilPrice: pricePerLiter,
                      customerLocation: companyAddress,
                      pickupDate: pickupDate,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'CHOOSE',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactIconButton(IconData iconData) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          color: Colors.grey[400],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(12)),
      child: IconButton(
        icon: Icon(iconData, color: Colors.white),
        onPressed: () {
          // Add specific functionality for each icon
        },
      ),
    );
  }
}
