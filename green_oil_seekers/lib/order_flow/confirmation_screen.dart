import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_oil_seekers/nav_bar.dart';

import 'order_details_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final String oilType;
  final double qtyOil;
  final String cityName;
  final String companyName;
  final String orderId;
  final String customerLocation;
  final String pickupDate;

  ConfirmationScreen({
    super.key,
    required this.oilType,
    required this.qtyOil,
    required this.cityName,
    required this.companyName,
    required this.customerLocation,
    required this.pickupDate,
    required double totalAmount,
  }) : orderId = _generateOrderId();

  static String _generateOrderId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(8, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/screen_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Vector.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                Text(
                  "Order has been placed successfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your support helps the environment\nthrough recycling!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 320,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderDetailsScreen(
                            orderId: orderId,
                            oilType: oilType,
                            qtyOil: 1,
                            cityName: cityName,
                            companyName: companyName,
                            customerLocation: customerLocation,
                            pickupDate: pickupDate,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 100,
                      ),
                    ),
                    child: Text(
                      "VIEW ORDER",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const NavBar(
                          wantedPage: 0,
                        ),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      decoration: TextDecoration.underline,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
