import 'package:flutter/material.dart';

import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/order_flow/offer_detail_screen.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({
    super.key,
    required this.offer,
    required this.isSelected,
    required this.onSelect,
  });

  final Offer offer;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${offer.arrivalDate.day}/${offer.arrivalDate.month}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: GestureDetector(
        onTap: onSelect,
        child: Card(
          color: Theme.of(context).colorScheme.onPrimary,
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OfferDetailsScreen(
                              offer: offer,
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/home_img.png',
                          width: 85,
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OfferDetailsScreen(
                                    offer: offer,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              getOrderType(offer),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Quantity: ${offer.oilQuantity} L',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Price per liter: ${(offer.oilPrice / offer.oilQuantity).toStringAsFixed(2)} SAR',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Pickup Date: $formattedDate',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Radio<int>(
                    value: 1, // The index of this offer
                    groupValue: isSelected ? 1 : null, // Selected state
                    onChanged: (_) => onSelect(), // Notify parent
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    '${offer.oilPrice} SAR',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String getOrderType(Offer offer) {
  if (offer.oilType == OilType.cookingOil) {
    return "Cooking Oil";
  } else if (offer.oilType == OilType.motorOil) {
    return "Motor Oil";
  } else if (offer.oilType == OilType.lubricating) {
    return "Lubricating Oil";
  } else {
    return "ERROR";
  }
}
