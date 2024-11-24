import 'package:flutter/material.dart';

import 'package:green_oil_seekers/order_flow/offers_list/offer_item.dart';
import 'package:green_oil_seekers/models/offer.dart';

class OffersList extends StatelessWidget {
  const OffersList({
    super.key,
    required this.offers,
    required this.selectedOfferIndex,
    required this.onSelect,
  });

  final List<Offer> offers;
  final int? selectedOfferIndex;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (ctx, index) => OfferItem(
        offer: offers[index],
        isSelected: selectedOfferIndex == index,
        onSelect: () => onSelect(index),
      ),
    );
  }
}
