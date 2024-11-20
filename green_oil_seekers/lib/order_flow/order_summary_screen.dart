import 'package:flutter/material.dart';

import '../primary_button.dart';
import 'payment_screen.dart';

class OrderSummaryScreen extends StatelessWidget {
  final String companyName;
  final String oilType;
  final int qtyOil;
  final double oilPrice;
  final String customerLocation;
  final String pickupDate;

  const OrderSummaryScreen({
    super.key,
    required this.companyName,
    required this.oilType,
    required this.qtyOil,
    required this.oilPrice,
    required this.customerLocation,
    required this.pickupDate,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const double serviceFee = 50.0;
    final double totalPayment = oilPrice * qtyOil + serviceFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Summary',
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
            Card(
              color: colorScheme.onPrimary,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryRow(context, 'Company Name', companyName),
                    _buildDivider(),
                    _buildSummaryRow(context, 'Oil Type', oilType),
                    _buildDivider(),
                    _buildSummaryRow(
                        context, 'Estimated Quantity', '$qtyOil L'),
                    _buildDivider(),
                    _buildSummaryRow(
                        context, 'Customer Location', customerLocation,
                        isTruncated: true),
                    _buildDivider(),
                    _buildSummaryRow(context, 'Pickup Date', pickupDate),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Payment details title above the card
            const Text(
              'Payment Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Payment details card
            Card(
              color: colorScheme.onPrimary,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryRow(context, 'Oil Price',
                        '${(oilPrice * qtyOil).toStringAsFixed(0)} SAR'),
                    _buildDivider(),
                    _buildSummaryRow(context, 'Services', '50 SAR'),
                    _buildDivider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _buildSummaryRow(
                        context,
                        'Total Payment',
                        '${totalPayment.toStringAsFixed(0)} SAR',
                        isBold: true,
                        isGreen: true, // Updated for green color
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreen(
                      oilType: oilType,
                      qtyOil: qtyOil,
                      companyName: companyName,
                      customerLocation: customerLocation,
                      pickupDate: pickupDate,
                      oilPrice: oilPrice,
                    ),
                  ),
                );
              },
              label: 'NEXT',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(BuildContext context, String label, String value,
      {bool isTruncated = false, bool isBold = false, bool isGreen = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            label,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
                color: isGreen ? Theme.of(context).colorScheme.primary : null), // Green for Total Payment
            overflow:
                isTruncated ? TextOverflow.ellipsis : TextOverflow.visible,
            maxLines: 1,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }

  Divider _buildDivider() => Divider(color: Colors.grey.shade400);
}
