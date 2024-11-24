import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/schedule_screen/orders_list/order_item.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({
    super.key,
    required this.offers,
  });

  final List<Offer> offers;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: offers.length,
      itemBuilder: (ctx, index) => OrderItem(
        offer: offers[index],
      ),
    );
  }
}
