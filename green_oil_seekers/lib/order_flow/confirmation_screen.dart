import 'package:flutter/material.dart';
import 'package:green_oil_seekers/nav_bar.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              children: [
                const SizedBox(height: 132),
                Image.asset(
                  'assets/images/Vector.png',
                  width: 225,
                  height: 225,
                ),
                const SizedBox(height: 0),
                Text(
                  "Order has been placed \nsuccessfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Your support helps the environment\nthrough recycling!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 32),
                // Primary Button
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Schedule screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavBar(
                            wantedPage: 1,
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
                        vertical: 15,
                        horizontal: 75,
                      ),
                    ),
                    child: Text(
                      "VIEW ORDERS",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24), // Spacer between buttons
                // Back to Home Button
                TextButton(
                  onPressed: () {
                    // Navigate to Home Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavBar(
                          wantedPage: 0,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationColor: Theme.of(context).colorScheme.primary,
                      shadows: [
                        Shadow(
                          color: Theme.of(context).colorScheme.primary,
                          // Match background color to create "gap"
                          offset: const Offset(0, -5),
                          // Adjust vertical offset to control space
                        ),
                      ],
                      decorationThickness: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
