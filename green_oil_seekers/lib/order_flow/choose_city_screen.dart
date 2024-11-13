import 'package:flutter/material.dart';
import 'package:green_oil_seekers/primary_button.dart';

import 'choose_offer_screen.dart';
import 'payment_screen.dart';

class ChooseCityScreen extends StatefulWidget {
  const ChooseCityScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChooseCityScreenState();
  }
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
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
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
          color: Theme.of(context).colorScheme.secondary,
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
              'Choose Factory/Company',
              selectedCompany,
              companies,
              (value) {
                setState(() {
                  selectedCompany = value;
                });
              },
            ),
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
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.2),
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
                        color: selectedOffer.isEmpty
                            ? Theme.of(context).disabledColor
                            : Theme.of(context).colorScheme.secondary,
                        fontSize: 18,
                      ),
                    ),
                    Icon(Icons.tune, color: Theme.of(context).disabledColor),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (selectedOfferDetails != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.2),
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
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
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
            PrimaryButton(
              onPressed: () {
                selectedOfferDetails != null &&
                        selectedCity != null &&
                        selectedCompany != null
                    ? () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PaymentScreen(
                              oilPrice:
                                  selectedOfferDetails!['price'].toDouble(),
                              cityName: selectedCity!,
                              companyName: selectedCompany!,
                              oilType: selectedOfferDetails!['oilType'],
                              qtyOil:
                                  selectedOfferDetails!['quantity'].toDouble(),
                            ),
                          ),
                        );
                      }
                    : null;
              },
              backgroundColor: selectedOfferDetails == null
                  ? Theme.of(context).disabledColor
                  : Theme.of(context).colorScheme.primary,
              label: 'NEXT',
              vertical: 13,
              horizontal: 145,
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
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        hint: Text(hint,
            style: TextStyle(color: Theme.of(context).disabledColor)),
        underline: const SizedBox(),
        icon:
            Icon(Icons.arrow_drop_down, color: Theme.of(context).disabledColor),
        dropdownColor: Theme.of(context).colorScheme.onPrimary,
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
