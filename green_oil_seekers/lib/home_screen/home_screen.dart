import 'package:flutter/material.dart';
import 'package:green_oil_seekers/chooseCity_screen/choose_city_screen.dart';
import 'package:green_oil_seekers/home_screen/recycle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void chooseCity(BuildContext context) {
    // Navigate to ChooseCityScreen when the user clicks on the "Choose City" button
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ChooseCityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Background image starting after "View Last Purchases"
            Positioned.fill(
              top: 430, // Increase this value to move the image down
              child: Image.asset(
                'assets/images/splash_img.png',
                fit: BoxFit.cover, // Cover the full area
                alignment: Alignment
                    .bottomCenter, // Align it to the bottom of the screen
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Image and Title
                SizedBox(
                  width: double.infinity,
                  height: 390, // Same vertical size as before
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/home_img.png', // Placeholder for the background image
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      const Positioned(
                        top: 60,
                        left: 16,
                        right: 16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Be Recycled',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 0),
                            Text(
                              'Help the planet & earn \nrewards!',
                              style: TextStyle(
                                color: Colors.white,
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
                          decoration: const BoxDecoration(
                            color: Color(0xFFF8F8F8),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                      ),
                      // Address Section
                      const Positioned(
                        bottom: 22,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Colors.green),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Company Address: Jeddah - Alrabwah 23553, Asbat Bin...',
                                style: TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFE5E5EA),
                      hintText: 'Search',
                      hintStyle: const TextStyle(color: Color(0xFF909095)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
                // Recycle Your Oil Now Button
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: RecycleButton(
                    onRecycleOil: () {
                      chooseCity(context);
                    },
                  ),
                ),
                // View Last Purchases
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      // Add action for view purchases
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'View Last Purchases',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
                // Bottom Section with Background Image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 30),
                      RichText(
                        textAlign: TextAlign.left,
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'From Waste to\n',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'Green ',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.green,
                              ),
                            ),
                            TextSpan(
                              text: 'Solutions',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'We are a company that facilitates\n'
                        'the exchange of used oil between\n'
                        'companies and individuals.',
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            // Add contact us action
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            fixedSize: const Size(125, 32),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
