import 'package:flutter/material.dart';
import 'package:green_oil_seekers/schedule_screen/order_switcher.dart';
import 'package:green_oil_seekers/schedule_screen/order_details.dart';
import 'package:green_oil_seekers/models/offer.dart';

// StatelessWidget for displaying a schedule screen that contains an overview of orders.
class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  // Function to navigate to the OrderDetails screen for a specific order.
  void viewOrderDetails(BuildContext context, Offer offer) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetails(
          offer: offer, // Passes the offer to the OrderDetails screen.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .scaffoldBackgroundColor, // Sets the background color of the scaffold.
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80, // Provides vertical spacing at the top of the screen.
            ),
            Text(
              "Schedule", // Title of the screen.
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary, // Text color.
                fontSize: 28, // Font size for the title.
                fontWeight: FontWeight.w900, // Font weight for the title.
              ),
              textAlign: TextAlign.center, // Centers the title text.
            ),
            const SizedBox(
              height: 20, // Provides vertical spacing after the title.
            ),
            const Expanded(
              child:
                  OrderSwitcher(), // The widget that allows switching between different order views.
            ),
          ],
        ),
      ),
    );
  }
}
