import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/schedule_screen/schedule_screen.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.offer,
  });

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${offer.arrivalDate.day}/${offer.arrivalDate.month}/${offer.arrivalDate.year}';
    return Column(
      children: [
        getOrderStatus(offer, context),
        Card(
          elevation: 2,
          color: Theme.of(context).colorScheme.onPrimary,
          margin: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 5,
          ), // Space around the card
          child: Padding(
            padding: const EdgeInsets.all(12.0), // Padding inside the card
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order ID
                buildDetailItem(
                  'Order ID',
                  offer.orderID.substring(offer.orderID.length - 10),
                  context,
                ),
                Divider(thickness: 1.2, height: 10), // Add a divider here

                // Order Type
                buildDetailItem(
                  'Oil Type',
                  getOrderType(offer),
                  context,
                ),
                Divider(thickness: 1.2, height: 10), // Add a divider here

                // Oil Quantity and Points
                buildDetailItem(
                  'Estimated Quantity',
                  '${offer.oilQuantity.toStringAsFixed(1)}L',
                  context,
                ),
                Divider(thickness: 1.2, height: 10), // Add a divider here

                // Pickup Date
                buildDetailItem(
                  'Pickup Date',
                  formattedDate,
                  context,
                ),
                const SizedBox(height: 5),

                // View Details Link
                Container(
                  height: 40, // Adjust the height as needed
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      const ScheduleScreen().viewOrderDetails(context, offer);
                    },
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

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

Widget getOrderStatus(Offer offer, BuildContext context) {
  if (offer.orderStatus == OrderStatus.pending) {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.update,
          color: Theme.of(context).disabledColor,
          size: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Pending",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ],
    );
  } else if (offer.orderStatus == OrderStatus.accepted) {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.sync_rounded,
          color: Theme.of(context).colorScheme.secondaryContainer,
          size: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Accepted",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      ],
    );
  } else if (offer.orderStatus == OrderStatus.pickupScheduled) {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.sync_rounded,
          color: Theme.of(context).colorScheme.secondaryContainer,
          size: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Pickup Scheduled",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
      ],
    );
  } else if (offer.orderStatus == OrderStatus.completed) {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.check_circle_outline_rounded,
          color: Theme.of(context).colorScheme.primary,
          size: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Completed",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ],
    );
  } else {
    return Row(
      children: [
        const SizedBox(width: 14),
        Icon(
          Icons.cancel_outlined,
          color: Theme.of(context).colorScheme.error,
          size: 32,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Cancelled",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ],
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
