import 'package:flutter/material.dart';

import 'oil_type_selection.dart'; // Import your custom widgets if needed
import 'range_section.dart';

void showOfferSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.9, // 90% of the screen height
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Offers',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 16),

              // Oil Type Selection
              const Text('Oil type',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              OilTypeSelection(), // Add the oil type selection widget
              const SizedBox(height: 16),

              // Quantity Range Input
              const RangeSection(
                  title: 'Quantity', unit: 'L', min: 100.0, max: 10000.0),
              const SizedBox(height: 16),

              // Price Range Input
              const RangeSection(
                  title: 'Price', unit: 'SAR', min: 3.00, max: 10.00),
              const Text('*Note: price is per liter',
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 16),

              // Distance Range Input
              const RangeSection(
                  title: 'Distance', unit: 'KM', min: 5.0, max: 1000.0),
              const SizedBox(height: 16),

              // Find Offers Button
              ElevatedButton(
                onPressed: () {
                  // Handle filtering logic here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF47AB4D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'FIND OFFERS',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
