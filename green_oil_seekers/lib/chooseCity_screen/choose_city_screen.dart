import 'package:flutter/material.dart';

import 'choose_offer.dart';
import 'payment.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({Key? key}) : super(key: key);

  @override
  _ChooseCityScreenState createState() => _ChooseCityScreenState();
}

class _ChooseCityScreenState extends State<ChooseCityScreen> {
  String? selectedCity;
  String? selectedCompany;
  String selectedOffer = '';
  Map<String, dynamic>? selectedOfferDetails;

  final List<String> cities = [
    'Jeddah',
    'Riyadh',
    'Al Madinah',
    'Khobar',
    'Makkah',
    'Dammam'
  ];
  final List<String> companies = ['Moblpetroleum', 'Green Oil'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Complete Order',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildDropdownButton('Choose City', selectedCity, cities, (value) {
              setState(() {
                selectedCity = value;
              });
            }),
            const SizedBox(height: 16),
            buildDropdownButton(
                'Choose Factory/Company', selectedCompany, companies, (value) {
              setState(() {
                selectedCompany = value;
              });
            }),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                final offer = await showOfferSheet(context);
                if (offer != null) {
                  setState(() {
                    selectedOfferDetails = offer as Map<String, dynamic>?;
                    selectedOffer = offer['oilType'];
                  });
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      selectedOffer.isEmpty
                          ? 'Choose Offer'
                          : 'Selected Offer: $selectedOffer',
                      style: TextStyle(
                        color:
                            selectedOffer.isEmpty ? Colors.grey : Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    const Icon(Icons.tune, color: Colors.grey),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (selectedOfferDetails != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      selectedOfferDetails!['oilType'],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text('Quantity: ${selectedOfferDetails!['quantity']} L'),
                    Text(
                        'Price per liter: ${selectedOfferDetails!['price']} SAR'),
                    Text('Distance: ${selectedOfferDetails!['distance']} KM'),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Total: ${(selectedOfferDetails!['quantity'] * selectedOfferDetails!['price']).toStringAsFixed(2)} SAR',
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            ElevatedButton(
              onPressed: selectedOfferDetails != null &&
                      selectedCity != null &&
                      selectedCompany != null
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentScreen(
                            oilPrice: selectedOfferDetails!['price'].toDouble(),
                            cityName: selectedCity!,
                            companyName: selectedCompany!,
                            oilType: selectedOfferDetails!['oilType'],
                            qtyOil:
                                selectedOfferDetails!['quantity'].toDouble(),
                          ),
                        ),
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedOfferDetails == null
                    ? Colors.grey[400]
                    : Colors.green,
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'NEXT',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget buildDropdownButton(String hint, String? value, List<String> items,
      ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        hint: Text(hint, style: const TextStyle(color: Colors.grey)),
        underline: const SizedBox(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value, style: const TextStyle(fontSize: 18)),
          );
        }).toList(),
      ),
    );
  }
}
