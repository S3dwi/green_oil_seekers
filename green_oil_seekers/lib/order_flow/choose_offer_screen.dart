import 'package:flutter/material.dart';
import '../primary_button.dart';
import 'oil_type_selection_screen.dart';
import 'range_section_screen.dart';
import 'pick_offer_screen.dart';

class ChooseOfferScreen extends StatefulWidget {
  const ChooseOfferScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChooseOfferScreenState();
  }
}

class _ChooseOfferScreenState extends State<ChooseOfferScreen> {
  List<String> selectedOilTypes = [];
  double minQuantity = 100.0;
  double maxQuantity = 10000.0;
  double minPrice = 3.0;
  double maxPrice = 10.0;

  // Handle the selected oil types
  void _onOilTypeSelected(List<String> selectedTypes) {
    setState(() {
      selectedOilTypes = selectedTypes;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Filter Offers',
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
            // Oil Type selection
            const Text(
              'Oil Type',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            OilTypeSelection(
              onSelected: _onOilTypeSelected,
              selectedOilTypes: selectedOilTypes,
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),

            // Quantity range
            const Text(
              'Quantity (L)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RangeSection(
              title: 'Quantity',
              unit: 'L',
              min: minQuantity,
              max: maxQuantity,
              onRangeSelected: (min, max) {
                setState(() {
                  minQuantity = min;
                  maxQuantity = max;
                });
              },
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),

            // Price range
            const Text(
              'Price per Liter (SAR)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            RangeSection(
              title: 'Price',
              unit: 'SAR',
              min: minPrice,
              max: maxPrice,
              onRangeSelected: (min, max) {
                setState(() {
                  minPrice = min;
                  maxPrice = max;
                });
              },
            ),
            const Text(
              '*Note: price is per liter',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 16),

            // Choose button
            PrimaryButton(
              label: 'CHOOSE',
              onPressed: selectedOilTypes.isNotEmpty
                  ? () {
                      // Pass selected oil types and filter values to PickOfferScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PickOfferScreen(
                            selectedOilTypes: selectedOilTypes,
                            minQuantity: minQuantity,
                            maxQuantity: maxQuantity,
                            minPrice: minPrice,
                            maxPrice: maxPrice,
                          ),
                        ),
                      );
                    }
                  : () {},
              backgroundColor: selectedOilTypes.isNotEmpty
                  ? colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
          ],
        ),
      ),
    );
  }
}
