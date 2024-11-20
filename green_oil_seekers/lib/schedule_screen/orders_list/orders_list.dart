import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/order.dart';
import 'package:green_oil_seekers/schedule_screen/orders_list/order_item.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key, required this.orders});

  final List<Order> orders;

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (ctx, index) => OrderItem(order: orders[index]),
    );
  }
}