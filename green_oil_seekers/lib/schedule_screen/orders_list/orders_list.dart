import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/schedule_screen/orders_list/order_item.dart';

// StatelessWidget that creates a list view of order items.
class OrdersList extends StatelessWidget {
  const OrdersList({
    super.key,
    required this.offers, // A list of Offer objects to display.
  });

  final List<Offer> offers; // The list of offers passed to the widget.

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: offers
          .length, // The number of items in the list equals the number of offers.
      itemBuilder: (ctx, index) => OrderItem(
        offer: offers[index], // Pass each offer to the OrderItem widget.
      ),
      // This builder iterates over each offer in the list and creates an OrderItem widget for it.
      // The OrderItem widget is responsible for displaying the details of each offer in a card format.
    );
  }
}
