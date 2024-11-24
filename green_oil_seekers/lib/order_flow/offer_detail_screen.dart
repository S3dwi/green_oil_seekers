import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:green_oil_seekers/order_flow/order_summery_screen.dart';
import 'package:green_oil_seekers/primary_button.dart';
import 'package:green_oil_seekers/models/offer.dart';

class OfferDetailsScreen extends StatelessWidget {
  const OfferDetailsScreen({
    super.key,
    required this.offer,
  });

  final Offer offer;

  void _sendEmail() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: offer.customerInfo.providerEmail,
      query: encodeQueryParameters(<String, String>{
        'subject': offer.customerInfo.companyName,
      }),
    );

    launchUrl(emailLaunchUri);
  }

  void _openWhatsApp() async {
    Uri whatsappUrl =
        Uri.parse("https://wa.me/966${offer.customerInfo.phoneNumber}");

    launchUrl(whatsappUrl);
  }

  void _calling() async {
    final Uri url = Uri(
      scheme: 'tel',
      path: offer.customerInfo.phoneNumber, // Phone number to dial
    );
    launchUrl(url);
  }

  bool isValidUrl(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${offer.arrivalDate.day}/${offer.arrivalDate.month}';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 37),
            Text(
              "Offers",
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 28,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Theme.of(context).colorScheme.onPrimary,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 28,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            // Since the width and height of your original image are 85
                            backgroundImage: isValidUrl(
                                    offer.customerInfo.image.trim())
                                ? NetworkImage(offer.customerInfo.image.trim())
                                : const AssetImage(
                                    'assets/images/profile_picture.png',
                                  ) as ImageProvider,
                            backgroundColor: Colors.transparent,
                            // Optional: To avoid any background color
                          ),
                          const SizedBox(height: 10),
                          Text(
                            offer.customerInfo.companyName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      getOrderType(offer),
                      style: TextStyle(
                        fontSize: 18,
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
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
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'SAR ${offer.oilPrice}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 22),

          // Contact Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contact ${offer.customerInfo.companyName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildContactIconButton(
                      context,
                      Icons.phone,
                      _calling,
                    ),
                    _buildContactIconButton(
                      context,
                      Icons.email,
                      _sendEmail,
                    ),
                    _buildContactIconButton(
                      context,
                      Icons.message,
                      _openWhatsApp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          // Company Location Section
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  'Company Location',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              color: Theme.of(context).colorScheme.onPrimary,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primary,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the start
                        children: [
                          Text(
                            "Company Address",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            offer.location.toString(),
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            softWrap:
                                true, // Allow text to wrap to the next line
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.directions,
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                      onPressed: () {
                        // Directions functionality here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          const Spacer(),
          // Choose Button
          PrimaryButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => OrderSummeryScreen(
                    offer: offer,
                  ),
                ),
              );
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'CHOOSE',
            vertical: 13,
            horizontal: 129.9,
          ),

          const SizedBox(height: 38),
        ],
      ),
    );
  }

  Widget _buildContactIconButton(
      BuildContext context, IconData iconData, void Function() onPressed) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(iconData, color: Theme.of(context).colorScheme.onSecondary),
        onPressed: onPressed,
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
