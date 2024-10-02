import 'package:flutter/material.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ChooseCityScreenState();
  }
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  // List of cities
  final List<String> cities = [
    'Al Madinah',
    'Dammam',
    'Jeddah',
    'Khobar',
    'Makkah',
    'Riyadh'
  ];
  // List of companies
  final List<String> companies = ['Moblpetroleum', 'Green Oil'];

  // Variables to store selected city and company
  String? selectedCity;
  String? selectedCompany;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigates back to HomeScreen
          },
        ),
        title: const Text('Complete Order'),
        backgroundColor: Colors.white,
        elevation: 0, // No shadow
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Dropdown for choosing city
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Choose the city',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(),
              ),
              value: selectedCity,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCity = newValue;
                });
              },
              items: cities.map((city) {
                return DropdownMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Dropdown for choosing company
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Choose Factory/Company',
                border: OutlineInputBorder(),
              ),
              value: selectedCompany,
              onChanged: (String? newValue) {
                setState(() {
                  selectedCompany = newValue;
                });
              },
              items: companies.map((company) {
                return DropdownMenuItem(
                  value: company,
                  child: Text(company),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Button for Choose Offer (future implementation)
            ElevatedButton(
              onPressed: () {
                // Handle offer selection in future
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Choose Offer'),
                  SizedBox(width: 8),
                  Icon(Icons.tune),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Next button
            ElevatedButton(
              onPressed: () {
                // You can add the logic for the Next button here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // Button color
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('NEXT'),
            ),
          ],
        ),
      ),
    );
  }
}
