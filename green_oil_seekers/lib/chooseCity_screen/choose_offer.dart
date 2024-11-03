import 'package:flutter/material.dart';

import 'oil_type_selection.dart';
import 'pick_offer_screen.dart';
import 'range_section.dart';

Future<Map<String, dynamic>?> showOfferSheet(BuildContext context) {
  return showModalBottomSheet<Map<String, dynamic>>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => _ChooseOfferOverlay(),
  );
}

class _ChooseOfferOverlay extends StatefulWidget {
  @override
  __ChooseOfferOverlayState createState() => __ChooseOfferOverlayState();
}

class __ChooseOfferOverlayState extends State<_ChooseOfferOverlay> {
  bool isFiltering = true;
  bool isOilTypeSelected = false;

  double minQuantity = 100.0;
  double maxQuantity = 10000.0;
  double minPrice = 3.0;
  double maxPrice = 10.0;
  double minDistance = 5.0;
  double maxDistance = 1000.0;

  void _onFindOffers() {
    setState(() {
      isFiltering = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isFiltering ? 'Offers' : 'Pick Offer'),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (!isFiltering) {
                setState(() {
                  isFiltering = true;
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isFiltering ? _buildFilterView() : const PickOfferScreen(),
        ),
      ),
    );
  }

  Widget _buildFilterView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Oil type', style: TextStyle(fontWeight: FontWeight.bold)),
        OilTypeSelection(
          onSelected: (selectedOilTypes) {
            setState(() {
              isOilTypeSelected = selectedOilTypes.isNotEmpty;
            });
          },
        ),
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
        ),
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
        ),
        const Text(
          '*Note: price is per liter',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
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
        ),
        const Spacer(),
        ElevatedButton(
          onPressed: isOilTypeSelected ? _onFindOffers : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isOilTypeSelected ? Colors.green : Colors.grey,
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
    );
  }
}
