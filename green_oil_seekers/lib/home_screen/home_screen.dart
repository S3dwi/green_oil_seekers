import 'package:flutter/material.dart';
import 'package:green_oil_seekers/chooseCity_screen/choose_city_screen.dart';
import 'package:green_oil_seekers/home_screen/last_order_button.dart';
import 'package:green_oil_seekers/home_screen/new_location.dart';
import 'package:green_oil_seekers/home_screen/recycle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void orderFlow(BuildContext context) {
    // Navigate to order flow
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChooseCityScreen(),
      ),
    );
  }

  // method to open the NewExpense page in Bottom sheet
  void _openAddExpense(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewLocation(),
    );
  }

  void lastOrder(BuildContext context) {
    // Navigate to order flow
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChooseCityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Recycle Button section
            SizedBox(
              width: double.infinity,
              height: 320, // Same vertical size as before
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/home_img.png', // Placeholder for the background image
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 60,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Be Recycled',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Help the planet & enjoy \nvaluable benefits!',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 24,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: double.infinity,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Theme.of(context).colorScheme.primary,
                              size: 30,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Jeddah - Alrabwah 23223, Bin Khalid Alansari, Near Albaik Almarwah branch 6977',
                                style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _openAddExpense(context);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down,
                                color: Theme.of(context).shadowColor,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 0,
                    left: 20,
                    right: 20,
                    child: Divider(),
                    //create line to separate between the components,
                  )
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15), // Same padding
              child: RecycleButton(
                orderFlow: () {
                  orderFlow(context);
                },
              ),
            ),

            const SizedBox(
              height: 32,
            ),

            // View Last Purchases
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: LastOrderButton(
                lastOrder: () {
                  lastOrder(context);
                },
              ),
            ),

            // Bottom Section with Background Image
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'From Waste to\n',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        TextSpan(
                          text: 'Green ',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        TextSpan(
                          text: 'Solutions',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w800,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We are a company that facilitates\n'
                    'the exchange of used oil between\n'
                    'companies and individuals.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add contact us action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        fixedSize: const Size(125, 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Contact Us',
                          style: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // Spacing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
