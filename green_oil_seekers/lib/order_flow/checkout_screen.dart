import 'package:flutter/material.dart';

import '../primary_button.dart';
import 'confirmation_screen.dart';

class CheckoutScreen extends StatelessWidget {
  final String oilType;
  final int qtyOil;
  final String companyName;
  final String customerLocation;
  final String pickupDate;
  final double subtotal;
  final double totalAmount;

  const CheckoutScreen({
    super.key,
    required this.oilType,
    required this.qtyOil,
    required this.companyName,
    required this.customerLocation,
    required this.pickupDate,
    required this.subtotal,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Payment Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildDetailRow('Oil Type', oilType),
                    _buildDivider(),
                    _buildDetailRow('Estimated Quantity', '$qtyOil L'),
                    _buildDivider(),
                    _buildDetailRow('Company Name', companyName),
                    _buildDivider(),
                    _buildDetailRow('Customer Location',
                        _truncateLocation(customerLocation)),
                    _buildDivider(),
                    _buildDetailRow('Pickup Date', pickupDate),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSummaryRow('Subtotal', '${subtotal.toInt()} SAR'),
                    _buildSummaryRow('Service Fee', '50 SAR'),
                    const Divider(),
                    _buildSummaryRow(
                      'Total (Incl. VAT)',
                      '${totalAmount.toInt()} SAR',
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'PAY',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationScreen(
                      oilType: oilType,
                      qtyOil: qtyOil.toDouble(),
                      companyName: companyName,
                      customerLocation: customerLocation,
                      pickupDate: pickupDate,
                      totalAmount: totalAmount,
                      cityName: '',
                    ),
                  ),
                );
              },
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('1 Item', style: TextStyle(fontSize: 18)),
                Text(
                  '${totalAmount.toStringAsFixed(2)} SAR',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const SizedBox(width: 8),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 150), // Set maximum width
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            overflow:
                TextOverflow.ellipsis, // Truncate overflow text with ellipsis
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              color: isBold ? Colors.green : null,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Divider _buildDivider() => Divider(color: Colors.grey.shade300);

  String _truncateLocation(String location) {
    return location.length > 25 ? '${location.substring(0, 25)}...' : location;
  }
}
