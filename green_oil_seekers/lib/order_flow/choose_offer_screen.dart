import 'package:flutter/material.dart';

import 'package:green_oil_seekers/order_flow/step_progress_indicator.dart';
import 'package:green_oil_seekers/order_flow/oil_type_selection.dart';
import 'package:green_oil_seekers/order_flow/pick_offer_screen.dart';
import 'package:green_oil_seekers/order_flow/range_section.dart';
import 'package:green_oil_seekers/primary_button.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // Ensures title is centered
        title: Column(
          children: [
            const SizedBox(height: 37),
            Text(
              "Filter",
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: StepProgressIndicator(
              currentStep: 0,
              totalSteps: 4,
            ),
          ),

          const Divider(),

          // Oil Type selection
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28,
              vertical: 12,
            ),
            child: Text(
              'Oil Type',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: OilTypeSelection(
              onSelected: _onOilTypeSelected,
              selectedOilTypes: selectedOilTypes,
            ),
          ),

          const SizedBox(height: 12),
          const Divider(),

          // Quantity range
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
            child: RangeSection(
              title: 'Quantity',
              titleStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
          ),
          const Divider(),
          const SizedBox(height: 12),
          // Price range
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: RangeSection(
              title: 'Price',
              titleStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Text(
              '*Note: price is per liter',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(height: 12),

          const Divider(),

          const Spacer(),

          // Choose button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
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
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor,
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
