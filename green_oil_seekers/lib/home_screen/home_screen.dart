import 'package:flutter/material.dart';
import 'package:green_oil_seekers/chooseCity_screen/choose_city_screen.dart';
import 'package:green_oil_seekers/home_screen/recycle_button.dart'; // Import ChooseCityScreen

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void chooseCity(BuildContext context) {
    // Navigate to ChooseCityScreen when the user clicks on the "Choose City" button
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>  ChooseCityScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Top Image and Title
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
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.search),
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
              child: ListTile(
                title: const Text('View Last Purchases'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  // Add action for view purchases
                },
              ),
            ),

            // Bottom section: From Waste to Green Solutions
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'From Waste to Green Solutions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We are a company that facilitates the exchange of used oil between companies and individuals.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Add contact us action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
