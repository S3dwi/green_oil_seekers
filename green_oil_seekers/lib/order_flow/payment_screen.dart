import 'package:flutter/material.dart';
import '../primary_button.dart';
import 'confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String oilType;
  final int qtyOil;
  final String companyName;
  final String customerLocation;
  final String pickupDate;
  final double oilPrice;

  const PaymentScreen({
    super.key,
    required this.oilType,
    required this.qtyOil,
    required this.companyName,
    required this.customerLocation,
    required this.pickupDate,
    required this.oilPrice,
  });

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    final double totalPrice =
        widget.oilPrice * widget.qtyOil + 50; // 50 SAR service fee
    final colorScheme = Theme.of(context).colorScheme;

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
            // Payment Method
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildPaymentOption('Apple Pay', 'assets/images/applePay.png'),
            const SizedBox(height: 8),
            _buildPaymentOption('Cash', 'assets/images/cash2.png'),
            const SizedBox(height: 8),
            _buildPaymentOption('Visa', 'assets/images/visaPay.png'),
            const SizedBox(height: 8),
            _buildPaymentOption('Paypal', 'assets/images/paypal.png'),
            const SizedBox(height: 24), // Large space as per Figma design
            // Order Summary Card
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              color: colorScheme.onPrimary,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildSummaryRow('Subtotal', '${(widget.oilPrice * widget.qtyOil).toInt()} SAR'),
                    _buildSummaryRow('Service Fee', '50 SAR'),
                    const Divider(),
                    _buildSummaryRow(
                      'Total (Incl. VAT)',
                      '${totalPrice.toInt()} SAR',
                      isBold: true,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(
              onPressed: selectedPaymentMethod != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmationScreen(
                            oilType: widget.oilType,
                            qtyOil: widget.qtyOil.toDouble(),
                            companyName: widget.companyName,
                            customerLocation: widget.customerLocation,
                            pickupDate: widget.pickupDate,
                            totalAmount: totalPrice,
                            cityName: '',
                          ),
                        ),
                      );
                    }
                  : (){},
              label: 'PAY',
              backgroundColor: selectedPaymentMethod != null
                  ? colorScheme.primary
                  : Theme.of(context).disabledColor,
            ),
          ],
        ),
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
        color: Theme.of(context).colorScheme.onPrimary,
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
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
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
            style: const TextStyle(
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
}
