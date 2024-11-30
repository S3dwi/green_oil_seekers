import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/order_flow/offer_detail_screen.dart';

class OfferItem extends StatelessWidget {
  // Constructor for the OfferItem widget with necessary properties.
  const OfferItem({
    super.key,
    required this.offer,
    required this.isSelected,
    required this.onSelect,
  });

  final Offer offer;
  final bool isSelected;
  final VoidCallback onSelect;

  // Helper method to validate if a given URL is valid.
  bool isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // Formatting the arrival date of the offer.
    String formattedDate =
        '${offer.arrivalDate.day}/${offer.arrivalDate.month}';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: GestureDetector(
        onTap:
            onSelect, // Executes the onSelect callback when the card is tapped.
        child: Card(
          color: Theme.of(context)
              .colorScheme
              .onPrimary, // Background color of the card.
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(12), // Rounded corners for the card.
          ),
          elevation: 6, // Shadow depth for the card.
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigates to the offer details screen when the avatar is tapped.
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OfferDetailsScreen(
                              offer: offer,
                            ),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        radius: 34, // Radius of the avatar.
                        backgroundImage: isValidUrl(
                                offer.customerInfo.image.trim())
                            ? NetworkImage(offer.customerInfo.image.trim())
                            : const AssetImage('assets/images/logo_grey.png')
                                as ImageProvider,
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigates to the offer details screen when the text is tapped.
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OfferDetailsScreen(
                                    offer: offer,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              getOrderType(
                                  offer), // Converts the oil type enum to a string.
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
                    value: 1,
                    groupValue:
                        isSelected ? 1 : null, // Selected state management.
                    onChanged: (_) =>
                        onSelect(), // Execute onSelect when the radio button is changed.
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    '${offer.oilPrice} SAR', // Displays the price of the oil.
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

// Function to convert the oil type enum to a readable string.
String getOrderType(Offer offer) {
  if (offer.oilType == OilType.cookingOil) {
    return "Cooking Oil";
  } else if (offer.oilType == OilType.motorOil) {
    return "Motor Oil";
  } else if (offer.oilType == OilType.lubricating) {
    return "Lubricating Oil";
  } else {
    return "ERROR"; // Error case if none of the expected types match.
  }
}
