import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/schedule_screen/schedule_screen.dart';

// Stateless widget that displays detailed information about an order in a card format.
class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.offer, // The offer data to display.
  });

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${offer.arrivalDate.day}/${offer.arrivalDate.month}/${offer.arrivalDate.year}';
    // Format the date from the offer's arrival date.

    return Column(
      children: [
        getOrderStatus(
            offer, context), // Display the current status of the order.
        Card(
          elevation: 2, // Adds elevation for shadow.
          color: Theme.of(context)
              .colorScheme
              .onPrimary, // Background color of the card.
          margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildDetailItem(
                    'Order ID',
                    offer.orderID.substring(offer.orderID.length - 10),
                    context),
                // Display the last 10 characters of the order ID.
                const Divider(thickness: 1.2, height: 10),
                buildDetailItem('Oil Type', getOrderType(offer),
                    context), // Display the type of oil for the order.
                const Divider(thickness: 1.2, height: 10),
                buildDetailItem('Estimated Quantity',
                    '${offer.oilQuantity.toStringAsFixed(1)}L', context),
                // Display the estimated quantity of oil.
                const Divider(thickness: 1.2, height: 10),
                buildDetailItem('Pickup Date', formattedDate,
                    context), // Display the formatted pickup date.
                const SizedBox(height: 5),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      const ScheduleScreen().viewOrderDetails(
                          context, offer); // Navigate to view detailed order.
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
        const SizedBox(height: 20),
      ],
    );
  }
}

// Helper function to build detailed row items inside the card.
Widget buildDetailItem(String label, String value, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
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

// Helper function to determine the status icon and text based on the order's current status.
Widget getOrderStatus(Offer offer, BuildContext context) {
  if (offer.orderStatus == OrderStatus.accepted) {
    return statusRow(Icons.sync_rounded, "Order Accepted",
        Theme.of(context).colorScheme.secondaryContainer, context);
  } else if (offer.orderStatus == OrderStatus.pickupScheduled) {
    return statusRow(Icons.sync_rounded, "Pickup Scheduled",
        Theme.of(context).colorScheme.secondaryContainer, context);
  } else if (offer.orderStatus == OrderStatus.completed) {
    return statusRow(Icons.check_circle_outline_rounded, "Completed",
        Theme.of(context).colorScheme.primary, context);
  } else {
    return statusRow(Icons.cancel_outlined, "Cancelled",
        Theme.of(context).colorScheme.error, context);
  }
}

// Helper function to create a row displaying the order status with an icon.
Widget statusRow(
    IconData icon, String text, Color color, BuildContext context) {
  return Row(
    children: [
      const SizedBox(width: 14),
      Icon(icon, color: color, size: 32),
      const SizedBox(width: 8),
      Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    ],
  );
}

// Helper function to determine the oil type based on the enum value from the offer.
String getOrderType(Offer offer) {
  if (offer.oilType == OilType.cookingOil) {
    return "Cooking Oil";
  } else if (offer.oilType == OilType.motorOil) {
    return "Motor Oil";
  } else if (offer.oilType == OilType.lubricating) {
    return "Lubricating Oil";
  } else {
    return "ERROR"; // Fallback error message.
  }
}
