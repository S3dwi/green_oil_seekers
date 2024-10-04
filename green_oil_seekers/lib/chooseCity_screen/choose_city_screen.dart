import 'package:flutter/material.dart';

import 'choose_offer.dart'; // Import the modal logic

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ChooseCityScreenState();
  }
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  final List<String> cities = [
    'Jeddah',
    'Riyadh',
    'Al Madinah',
    'Khobar',
    'Makkah',
    'Dammam'
  ];
  final List<String> companies = ['Moblpetroleum', 'Green Oil'];

  String? selectedCity;
  String? selectedCompany;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true, // Ensures title is centered
        title: const Text(
          'Complete Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 25,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Custom Dropdown for choosing city
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: const Text('Choose City'),
                      value: selectedCity,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCity = newValue;
                        });
                      },
                      items: [
                        // Custom Dropdown Header
                        const DropdownMenuItem<String>(
                          enabled: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Find City',
                                style: TextStyle(
                                    fontSize: 20, color: Color(0xFF737373)),
                              ),
                              SizedBox(height: 8), // Spacing
                              Divider(thickness: 1), // Line under "Find City"
                            ],
                          ),
                        ),
                        // The actual list of cities
                        ...cities.map(
                          (city) {
                            return DropdownMenuItem(
                              value: city,
                              child: Text(
                                city,
                                style: TextStyle(
                                  color: selectedCity == city
                                      ? const Color(0xFF47AB4D)
                                      : Colors.black, // Green when selected
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Dropdown for choosing company
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      hint: const Text('Choose Factory/Company'),
                      value: selectedCompany,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedCompany = newValue;
                        });
                      },
                      items: companies.map((company) {
                        return DropdownMenuItem(
                          value: company,
                          child: Text(
                            company,
                            style: TextStyle(
                              color: selectedCompany == company
                                  ? const Color(0xFF47AB4D)
                                  : Colors.black, // Green when selected
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Button for Choose Offer
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        showOfferSheet(context); // Show the modal bottom sheet
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Choose Offer',
                            style: TextStyle(
                                color: Color(0xFF737373), fontSize: 20),
                          ),
                          Icon(Icons.tune, color: Color(0xFF737373)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),

            // Next button at the bottom
            ElevatedButton(
              onPressed: () {
                // Handle next action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFA9A9AC), // Match the Figma grey
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 140),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
