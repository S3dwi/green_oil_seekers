import 'package:flutter/material.dart';
import 'package:green_oil_seekers/primary_button.dart';
import 'package:intl/intl.dart';

import 'confirmation_screen.dart';

class OrderSummary extends StatelessWidget {
  final double totalPayment;
  final String cityName;
  final String companyName;
  final String oilType;
  final double qtyOil;
  final DateTime arrivalDate;

  const OrderSummary({
    super.key,
    required this.totalPayment,
    required this.cityName,
    required this.companyName,
    required this.oilType,
    required this.qtyOil,
    required this.arrivalDate,
  });

  // Format date consistently
  String get formattedArrivalDate =>
      DateFormat('yyyy-MM-dd').format(arrivalDate);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Summary',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            _buildSummaryRow(
              'Total Payment',
              '${totalPayment.toStringAsFixed(1)} SAR',
              isBold: true,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Divider(),
            _buildSummaryRow('City Name', cityName),
            const Divider(),
            _buildSummaryRow('Company Name', companyName),
            const Divider(),
            _buildSummaryRow('Arrival Date', formattedArrivalDate),
            const Spacer(),
            PrimaryButton(
              label: 'PAY',
              onPressed: () => _navigateToConfirmation(context),
              backgroundColor: Theme.of(context).colorScheme.primary,
              textColor: Theme.of(context).colorScheme.onPrimary,
              verticalPadding: 16,
              horizontalPadding: 100,
              fontSize: 24,
              isEnabled: true,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _navigateToConfirmation(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ConfirmationScreen(
          oilType: oilType,
          qtyOil: qtyOil,
          cityName: cityName,
          companyName: companyName,
          arrivalDate: formattedArrivalDate,
          arrivalTime: '8:00am - 2:00pm',
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, Color color = Colors.black}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: color,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
