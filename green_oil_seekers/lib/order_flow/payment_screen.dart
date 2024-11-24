import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:green_oil_seekers/order_flow/step_progress_indicator.dart';
import 'package:green_oil_seekers/order_flow/confirmation_screen.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/pay_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    super.key,
    required this.offer,
  });
  final Offer offer;

  @override
  State<StatefulWidget> createState() {
    return _PaymentScreenState();
  }
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedPaymentMethod;
  bool _isLoading = false;

  void _submitRecyclingRequest() async {
    final seekerEmail = FirebaseAuth.instance.currentUser?.email;

    if (seekerEmail != null) {
      setState(() {
        _isLoading = true;
      });

      final databaseRef = FirebaseDatabase.instance.ref('requests');

      try {
        // Fetch all requests
        final snapshot = await databaseRef.get();

        if (snapshot.exists) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);

          // Loop through users and their requests to find the matching requestId
          for (var userId in data.keys) {
            final userRequests = Map<String, dynamic>.from(data[userId] as Map);

            if (userRequests.containsKey(widget.offer.orderID)) {
              // Found the request, update it
              final requestRef =
                  databaseRef.child('$userId/${widget.offer.orderID}');
              await requestRef.update({
                'seeker Email': seekerEmail,
                'order Status': 'accepted',
              });

              if (mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ConfirmationScreen(),
                  ),
                );
              }
              break; // Stop the loop once the request is updated
            }
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No requests found in the database.'),
              ),
            );
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update the request: $e'),
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false; // Stop loading
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 28),
            Text(
              "Checkout",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 25),
            child: StepProgressIndicator(
              currentStep: 3,
              totalSteps: 4,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          // Payment Method
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),

          _buildPaymentOption('Apple Pay', 'assets/images/applePay.png'),
          const SizedBox(height: 6),
          _buildPaymentOption('Cash', 'assets/images/cash2.png'),
          const SizedBox(height: 6),
          _buildPaymentOption('Visa', 'assets/images/visaPay.png'),
          const SizedBox(height: 6),
          _buildPaymentOption('Paypal', 'assets/images/paypal.png'),

          // Large space as per Figma design
          const SizedBox(height: 38),

          // Order Summary Card
          Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.onPrimary,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order Summary',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  buildDetailItem(
                    'Subtotal',
                    'SAR ${widget.offer.oilPrice}',
                    context,
                  ),
                  buildDetailItem(
                    'Service Fee',
                    'SAR 50',
                    context,
                  ),
                  const Divider(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            Text(
                              ' (Incl. VAT)',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.normal,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'SAR ${((widget.offer.oilPrice + 50) * 0.15) + widget.offer.oilPrice + 50}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Spacer(),

          PayButton(
            onPressed: (selectedPaymentMethod != null && !_isLoading)
                ? _submitRecyclingRequest
                : () {}, // Pass null when conditions are not met
            backgroundColor: selectedPaymentMethod != null
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).disabledColor,
            vertical: _isLoading ? 15 : 13,
            horizontal: _isLoading ? 165 : 160,
            child: _isLoading
                ? SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                : Text(
                    'PAY',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
          ),

          const SizedBox(height: 38),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: GestureDetector(
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
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
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
                Image.asset(
                  imagePath,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(width: 16),
                Text(
                  method,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildDetailItem(String label, String value, BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.onPrimary,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).disabledColor,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ],
    ),
  );
}
