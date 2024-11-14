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
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).colorScheme.secondary),
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
        Text(
          '*Note: price is per liter',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).disabledColor,
          ),
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
        PrimaryButton(
          onPressed: isOilTypeSelected ? _onFindOffers : () {},
          label: 'FIND OFFERS',
          backgroundColor: isOilTypeSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).disabledColor,
          textColor: Theme.of(context).colorScheme.onPrimary,
          verticalPadding: 16,
          horizontalPadding: 130,
          fontSize: 18,
          isEnabled: isOilTypeSelected,
        ),
      ],
    );
  }
}
