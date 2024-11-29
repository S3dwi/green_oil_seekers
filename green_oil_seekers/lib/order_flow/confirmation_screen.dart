import 'package:flutter/material.dart';
import 'package:green_oil_seekers/nav_bar.dart';

// StatelessWidget that displays a confirmation message after an order has been placed.
class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context)
          .scaffoldBackgroundColor, // Sets the background color from the theme.
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/screen_background.png', // Background image for the screen.
              fit: BoxFit.cover, // Ensures the image covers the whole screen.
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 132), // Spacing at the top.
                Image.asset(
                  'assets/images/Vector.png', // Image to signify successful order.
                  width: 225,
                  height: 225,
                ),
                const SizedBox(
                    height: 0), // Placeholder for potential future content.
                Text(
                  "Order has been placed \nsuccessfully!", // Confirmation message.
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .primary, // Text color for emphasis.
                    fontSize: 26,
                    fontWeight: FontWeight.w900, // Bold text for importance.
                  ),
                ),
                const SizedBox(height: 10), // Spacing after the main message.
                Text(
                  "Your support helps the environment\nthrough recycling!", // Supporting message.
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary, // Secondary text color.
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w400, // Regular weight for less emphasis.
                  ),
                ),
                const SizedBox(height: 32), // Spacing before the button.
                // Primary Button to view orders
                SizedBox(
                  width: 350,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Schedule screen to view orders
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NavBar(
                            wantedPage:
                                1, // Specifies which page of NavBar to navigate to.
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary, // Button color from theme.
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            8), // Rounded corners for the button.
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal:
                            75, // Horizontal padding to increase button width.
                      ),
                    ),
                    child: Text(
                      "VIEW ORDERS",
                      style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onSecondary, // Text color for high contrast.
                        fontSize: 20,
                        fontWeight: FontWeight.w900, // Bold text for emphasis.
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24), // Spacer between buttons.
                // Text button for returning to the home screen
                TextButton(
                  onPressed: () {
                    // Navigate back to Home Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavBar(
                          wantedPage: 0, // Specifies home page of NavBar.
                        ),
                      ),
                    );
                  },
                  child: Text(
                    "BACK TO HOME",
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .surface, // Color for the text.
                      fontSize: 22,
                      fontWeight: FontWeight.w600, // Slightly bold text.
                      decoration:
                          TextDecoration.underline, // Underlines the text.
                      decorationColor: Theme.of(context)
                          .colorScheme
                          .primary, // Color for the underline.
                      shadows: [
                        Shadow(
                          color: Theme.of(context)
                              .colorScheme
                              .primary, // Shadow color matches primary.
                          offset: const Offset(0,
                              -5), // Offset for shadow gives an embossed look.
                        ),
                      ],
                      decorationThickness: 1.5, // Thickness of the underline.
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Additional spacing at the bottom.
              ],
            ),
          ),
        ],
      ),
    );
  }
}
