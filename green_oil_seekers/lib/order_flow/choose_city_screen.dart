import 'package:flutter/material.dart';

import '../primary_button.dart';
import './dropdown.dart';
import 'choose_offer_screen.dart';

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

  final List<String> cities = [
    'Jeddah',
    'Riyadh',
    'Al Madinah',
    'Khobar',
    'Makkah',
    'Dammam',
  ];

  final List<String> companies = [
    'Moblpetroleum',
    'Green Oil',
  ];

  void _onChooseOffer() async {
    final selectedOfferDetails = await showOfferSheet(context);
    if (selectedOfferDetails != null) {
      setState(() {
        selectedOffer = 'Offer Selected';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: AppBar(
        title: Text(
          'Complete Order',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: colorScheme.secondary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colorScheme.secondary),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownWidget(
              selectedValue: selectedCity,
              hint: 'Choose City',
              items: cities,
              onChanged: (value) {
                setState(() {
                  selectedCity = value;
                });
              },
              isCityDropdown: true,
            ),
            const SizedBox(height: 20),
            DropdownWidget(
              selectedValue: selectedCompany,
              hint: 'Choose Factory/Company',
              items: companies,
              onChanged: (value) {
                setState(() {
                  selectedCompany = value;
                });
              },
              isCityDropdown: false,
            ),
            const SizedBox(height: 40),
            _buildOfferSelection(),
            const Spacer(),
            PrimaryButton(
              onPressed: (selectedCity != null &&
                      selectedCompany != null &&
                      selectedOffer.isNotEmpty)
                  ? _onNextPressed
                  : () {},
              backgroundColor: (selectedCity != null &&
                      selectedCompany != null &&
                      selectedOffer.isNotEmpty)
                  ? colorScheme.primary
                  : Theme.of(context).disabledColor,
              label: 'NEXT',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOfferSelection() {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          selectedOffer.isEmpty ? 'Choose Offer' : selectedOffer,
          style: TextStyle(
            color: selectedOffer.isEmpty
                ? colorScheme.secondary.withOpacity(0.6)
                : colorScheme.primary,
          ),
        ),
        trailing: Icon(Icons.tune, color: colorScheme.secondary),
        onTap: _onChooseOffer,
      ),
    );
  }

  void _onNextPressed() {
    // Implement navigation to the next screen
  }
}
