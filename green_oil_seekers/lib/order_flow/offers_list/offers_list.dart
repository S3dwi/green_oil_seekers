import 'package:flutter/material.dart';
import 'package:green_oil_seekers/order_flow/offers_list/offer_item.dart';
import 'package:green_oil_seekers/models/offer.dart';

// StatelessWidget to display a list of offers dynamically.
class OffersList extends StatelessWidget {
  // Constructor for OffersList, initializing with required parameters.
  const OffersList({
    super.key,
    required this.offers,
    required this.selectedOfferIndex,
    required this.onSelect,
  });

  // List of offers to be displayed.
  final List<Offer> offers;
  // Index of the currently selected offer, can be null.
  final int? selectedOfferIndex;
  // Callback to execute when an offer is selected.
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    // Builds a ListView that dynamically creates OfferItem widgets for each offer.
    return ListView.builder(
      itemCount:
          offers.length, // Number of items is the length of the offers list.
      itemBuilder: (ctx, index) => OfferItem(
        offer: offers[index], // Passes the specific offer at the current index.
        isSelected: selectedOfferIndex ==
            index, // Determines if the current item is selected.
        onSelect: () => onSelect(
            index), // Calls the onSelect callback with the current index.
      ),
    );
  }
}
