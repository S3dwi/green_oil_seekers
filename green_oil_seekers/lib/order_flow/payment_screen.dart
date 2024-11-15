import 'package:flutter/material.dart';

import '../primary_button.dart';
import 'checkout_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String oilType;
  final int qtyOil;
  final String companyName;
  final String customerLocation;
  final String pickupDate;
  final double oilPrice;

  const PaymentScreen({
    Key? key,
    required this.oilType,
    required this.qtyOil,
    required this.companyName,
    required this.customerLocation,
    required this.pickupDate,
    required this.oilPrice,
  }) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final double totalPrice =
        widget.oilPrice * widget.qtyOil + 50; // 50 SAR service fee

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
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
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriceRow(
                        'Oil Price', '${widget.oilPrice * widget.qtyOil} SAR'),
                    _buildPriceRow('Services', '50 SAR'),
                    const Divider(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _buildPriceRow(
                        'Total Payment',
                        '${totalPrice.toStringAsFixed(2)} SAR',
                        isBold: true,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildPaymentOption('Paypal', 'assets/images/paypal.png'),
            const SizedBox(height: 8),
            _buildPaymentOption('Cash', 'assets/images/cash2.png'),
            const Spacer(),
            PrimaryButton(
              onPressed: selectedPaymentMethod != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(
                            oilType: widget.oilType,
                            qtyOil: widget.qtyOil,
                            companyName: widget.companyName,
                            customerLocation: widget.customerLocation,
                            pickupDate: widget.pickupDate,
                            subtotal: widget.oilPrice * widget.qtyOil,
                            totalAmount: totalPrice,
                          ),
                        ),
                      );
                    }
                  : () {},
              label: 'NEXT',
              textColor: Colors.white, // Ensuring button text is white
              backgroundColor: selectedPaymentMethod != null
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              verticalPadding: 16.0,
              horizontalPadding: 100.0,
              isEnabled: selectedPaymentMethod != null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount,
      {bool isBold = false, double fontSize = 16}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
              color: isBold ? Theme.of(context).colorScheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, String imagePath) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
      },
      child: Card(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Radio<String>(
                value: method,
                groupValue: selectedPaymentMethod,
                onChanged: (value) {
                  setState(() {
                    selectedPaymentMethod = value;
                  });
                },
              ),
              const SizedBox(width: 8),
              Image.asset(imagePath, width: 40, height: 40),
              const SizedBox(width: 16),
              Text(
                method,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
