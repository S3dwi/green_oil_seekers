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
    Key? key,
    required this.companyName,
    required this.oilType,
    required this.qtyOil,
    required this.oilPrice,
    required this.customerLocation,
    required this.pickupDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalPayment =
        (qtyOil * oilPrice) + 50; // Adding service fee of SAR 50

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
              color: Theme.of(context).colorScheme.onPrimary,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSummaryRow('Company Name', companyName),
                    _buildDivider(),
                    _buildSummaryRow('Oil Type', oilType),
                    _buildDivider(),
                    _buildSummaryRow('Estimated Quantity', '$qtyOil L'),
                    _buildDivider(),
                    _buildSummaryRow('Customer Location', customerLocation,
                        isTruncated: true),
                    _buildDivider(),
                    _buildSummaryRow('Pickup Date', pickupDate),
                    _buildDivider(),
                    _buildSummaryRow('Offer Price',
                        '${(oilPrice * qtyOil).toStringAsFixed(2)} SAR'),
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

  Widget _buildSummaryRow(String label, String value,
      {bool isTruncated = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        SizedBox(
          width: 150, // Limiting width for text truncation
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
            overflow:
                isTruncated ? TextOverflow.ellipsis : TextOverflow.visible,
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Divider _buildDivider() => Divider(color: Colors.grey.shade300);
}
