import 'package:flutter/material.dart';
import 'package:green_oil_seekers/order_flow/order_summary_screen.dart';
import 'package:green_oil_seekers/primary_button.dart';

class PaymentScreen extends StatefulWidget {
  final double oilPrice;
  final String cityName;
  final String companyName;
  final String oilType;
  final double qtyOil;

  const PaymentScreen({
    super.key,
    required this.oilPrice,
    required this.cityName,
    required this.companyName,
    required this.oilType,
    required this.qtyOil,
  });

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isServiceExpanded = false;
  String? selectedPaymentMethod;
  final double serviceCharge = 50.0;
  final double deliveryCharge = 30.0;
  final double collectionCharge = 20.0;

  @override
  Widget build(BuildContext context) {
    final double finalOilPrice = widget.oilPrice * widget.qtyOil;
    final double totalPayment = finalOilPrice + serviceCharge;
    final arrivalDate = DateTime.now().add(const Duration(days: 3));

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Payment',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            _buildPaymentRow(
                'Oil Price', '${finalOilPrice.toStringAsFixed(1)} SAR'),
            const Divider(),
            GestureDetector(
              onTap: () {
                setState(() {
                  isServiceExpanded = !isServiceExpanded;
                });
              },
              child: _buildPaymentRow(
                'Services',
                '+$serviceCharge SAR',
                isExpandable: true,
              ),
            ),
            if (isServiceExpanded) ...[
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildPaymentRow(
                      'Delivery',
                      '+$deliveryCharge SAR',
                      fontSize: 14,
                    ),
                    _buildPaymentRow(
                      'Collection of oils',
                      '+$collectionCharge SAR',
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
            ],
            const Divider(),
            _buildPaymentRow(
              'Total Payment',
              '${totalPayment.toStringAsFixed(1)} SAR',
              isBold: true,
              color: Theme.of(context).colorScheme.primary,
            ),
            const Divider(),
            const SizedBox(height: 16),
            const Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            _buildPaymentMethodOption('Cash', 'assets/images/cash.png'),
            _buildPaymentMethodOption('Paypal', 'assets/images/paypal.png'),
            const Spacer(),
            PrimaryButton(
              onPressed: selectedPaymentMethod != null
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderSummary(
                            totalPayment: totalPayment,
                            cityName: widget.cityName,
                            companyName: widget.companyName,
                            oilType: widget.oilType,
                            qtyOil: widget.qtyOil,
                            arrivalDate: arrivalDate,
                          ),
                        ),
                      );
                    }
                  : () {}, // Pass an empty function if null to avoid type mismatch
              backgroundColor: selectedPaymentMethod != null
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).disabledColor,
              label: 'NEXT',
              textColor: Theme.of(context).colorScheme.onPrimary,
              verticalPadding: 16.0,
              horizontalPadding: 100.0,
              isEnabled: selectedPaymentMethod != null,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(
    String label,
    String value, {
    bool isBold = false,
    bool isExpandable = false,
    double fontSize = 16,
    Color color = Colors.black,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontSize: fontSize,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            if (isExpandable)
              Icon(
                isServiceExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                color: Theme.of(context).disabledColor,
              ),
          ],
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: color,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodOption(String label, String iconPath) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(12.0),
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
        children: [
          Radio<String>(
            value: label,
            activeColor: Theme.of(context).colorScheme.primary,
            groupValue: selectedPaymentMethod,
            onChanged: (String? value) {
              setState(() {
                selectedPaymentMethod = value;
              });
            },
          ),
          const SizedBox(width: 8),
          Image.asset(iconPath, width: 30),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
