import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/schedule_screen/invoice_screen.dart';
import 'package:green_oil_seekers/schedule_screen/track_order_screen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({
    super.key,
    required this.offer,
  });

  final Offer offer;

  Widget buildDetailItem(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${offer.arrivalDate.day}/${offer.arrivalDate.month}/${offer.arrivalDate.year}';
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // Ensures title is centered
        title: Column(
          children: [
            const SizedBox(
              height: 38,
            ),
            Text(
              "Schedule",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 5,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Information',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
            Card(
              elevation: 2,
              color: Theme.of(context).colorScheme.onPrimary,
              margin: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 5,
              ), // Space around the card
              child: Padding(
                padding: const EdgeInsets.all(10.0), // Padding inside the card
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Order ID
                    buildDetailItem(
                      'Order ID',
                      offer.orderID.substring(offer.orderID.length - 10),
                      context,
                    ),
                    const Divider(),
                    // Order Status
                    buildDetailItem(
                      'Order Status',
                      getOrderStatus(offer),
                      context,
                    ),
                    const Divider(),
                    // Oil Type
                    buildDetailItem(
                      'Oil Type',
                      getOrderType(offer),
                      context,
                    ),
                    const Divider(),
                    // Oil Quantity
                    buildDetailItem(
                      'Estimated Quantity',
                      '${offer.oilQuantity.toStringAsFixed(1)}L',
                      context,
                    ),
                    const Divider(),
                    // Oil Price
                    buildDetailItem(
                      'Oil Price',
                      '${offer.oilPrice.toStringAsFixed(1)} SR',
                      context,
                    ),
                    const Divider(),
                    // Arrival Date & Time
                    buildDetailItem(
                      'Pickup Date',
                      formattedDate,
                      context,
                    ),
                    const Divider(),
                    // Customer Location
                    buildDetailItem(
                      'Customer Location',
                      offer.location.toString(),
                      context,
                    ),
                    const Divider(),
                    const SizedBox(height: 20),

                    // Buttons: Invoice and Keep Track
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed:
                              offer.orderStatus == OrderStatus.completed ||
                                      offer.orderStatus == OrderStatus.cancelled
                                  ? () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              InvoiceScreen(offer: offer),
                                        ),
                                      );
                                    }
                                  : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary, // Always keep the same color
                            disabledBackgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5), // Same color when disabled
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(155, 50),
                          ),
                          child: Opacity(
                            opacity: offer.orderStatus ==
                                        OrderStatus.completed ||
                                    offer.orderStatus == OrderStatus.cancelled
                                ? 1.0
                                : 0.5, // Semi-transparent text if disabled
                            child: Text(
                              'Invoice',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: offer.orderStatus ==
                                      OrderStatus.completed ||
                                  offer.orderStatus == OrderStatus.cancelled
                              ? null
                              : () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => TrackOrderScreen(
                                        offer: offer,
                                      ),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context)
                                .colorScheme
                                .primary, // Always keep the same color
                            disabledBackgroundColor: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: const Size(180, 50),
                          ),
                          child: Opacity(
                            opacity: offer.orderStatus ==
                                        OrderStatus.completed ||
                                    offer.orderStatus == OrderStatus.cancelled
                                ? 0.5
                                : 1.0, // Semi-transparent text if disabled
                            child: Text(
                              'Track Order',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
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
    if (kDebugMode) {
      print("ERROR IN FETCHING ORDER TYPE");
    }
    return "ERROR";
  }
}

String getOrderStatus(Offer offer) {
  if (offer.orderStatus == OrderStatus.accepted) {
    return "Order Accepted";
  } else if (offer.orderStatus == OrderStatus.pickupScheduled) {
    return "Pickup Scheduled";
  } else if (offer.orderStatus == OrderStatus.completed) {
    return "Completed";
  } else if (offer.orderStatus == OrderStatus.cancelled) {
    return "Cancelled";
  } else {
    if (kDebugMode) {
      print("ERROR IN FETCHING ORDER STATUS");
    }
    return "ERROR";
  }
}
