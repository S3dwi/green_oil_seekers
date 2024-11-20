import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/order.dart';
import 'package:green_oil_seekers/schedule_screen/order_details.dart';
import 'package:green_oil_seekers/schedule_screen/order_switcher.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  void viewOrderDetails(BuildContext context, Order order) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OrderDetails(
          order: order,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            Text(
              "Schedule",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 28,
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(
              child: OrderSwitcher(),
            ),
          ],
        ),
      ),
    );
  }
}