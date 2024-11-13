import 'dart:math';

import 'package:flutter/material.dart';
import 'package:green_oil_seekers/nav_bar.dart';

import 'order_track_screen.dart';

class ConfirmationScreen extends StatelessWidget {
  final String oilType;
  final double qtyOil;
  final String cityName;
  final String companyName;
  final String arrivalDate;
  final String arrivalTime;
  final String orderId; // Add the orderId as a final property

  ConfirmationScreen({
    super.key,
    required this.oilType,
    required this.qtyOil,
    required this.cityName,
    required this.companyName,
    required this.arrivalDate,
    required this.arrivalTime,
  }) : orderId = _generateOrderId();

  // Generate a unique order ID
  static String _generateOrderId() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return List.generate(8, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                const Text(
                  "Order has been placed successfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Your support helps the environment\nthrough recycling!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 320,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderTrackScreen(
                            orderId: orderId,
                            oilType: oilType,
                            qtyOil: qtyOil,
                            cityName: cityName,
                            companyName: companyName,
                            arrivalDate: arrivalDate,
                            arrivalTime: arrivalTime,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 100,
                      ),
                    ),
                    child: const Text(
                      "VIEW ORDER",
                      style: TextStyle(
                        color: Colors.white,
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
                  child: const Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Colors.green,
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
