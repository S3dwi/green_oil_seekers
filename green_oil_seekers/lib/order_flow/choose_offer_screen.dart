import 'package:flutter/material.dart';

import '../primary_button.dart';
import 'oil_type_selection_screen.dart';
import 'pick_offer_screen.dart';
import 'range_section_screen.dart';

Future<Map<String, dynamic>?> showOfferSheet(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => const ChooseOfferOverlay(),
  );
}

class ChooseOfferOverlay extends StatefulWidget {
  const ChooseOfferOverlay({super.key});

  @override
  _ChooseOfferOverlayState createState() => _ChooseOfferOverlayState();
}

class _ChooseOfferOverlayState extends State<ChooseOfferOverlay> {
  bool isFiltering = true;
  bool isOilTypeSelected = false;

  double minQuantity = 100.0;
  double maxQuantity = 10000.0;
  double minPrice = 3.0;
  double maxPrice = 10.0;
  double minDistance = 5.0;
  double maxDistance = 1000.0;

  void _onFindOffers() {
    if (isOilTypeSelected) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) => const PickOfferScreen(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              Divider(color: Theme.of(context).disabledColor),
              const SizedBox(height: 16),
              const Text(
                'Oil type',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              OilTypeSelection(
                onSelected: (selectedOilTypes) {
                  setState(() {
                    isOilTypeSelected = selectedOilTypes.isNotEmpty;
                  });
                },
              ),
              Divider(color: Theme.of(context).disabledColor),
              const SizedBox(height: 16),
              RangeSection(
                title: 'Quantity',
                unit: 'L',
                min: minQuantity,
                max: maxQuantity,
                onRangeSelected: (min, max) {
                  minQuantity = min;
                  maxQuantity = max;
                },
                showTitle: false,
              ),
              Divider(color: Theme.of(context).disabledColor),
              const SizedBox(height: 16),
              RangeSection(
                title: 'Price',
                unit: 'SAR',
                min: minPrice,
                max: maxPrice,
                onRangeSelected: (min, max) {
                  minPrice = min;
                  maxPrice = max;
                },
                showTitle: false,
              ),
              Text(
                '*Note: price is per liter',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).disabledColor,
                ),
              ),
              Divider(color: Theme.of(context).disabledColor),
              const SizedBox(height: 16),
              RangeSection(
                title: 'Distance',
                unit: 'KM',
                min: minDistance,
                max: maxDistance,
                onRangeSelected: (min, max) {
                  minDistance = min;
                  maxDistance = max;
                },
                showTitle: false,
              ),
              const Spacer(),
              PrimaryButton(
                onPressed: _onFindOffers,
                label: 'FIND OFFERS',
                backgroundColor: isOilTypeSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).disabledColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
