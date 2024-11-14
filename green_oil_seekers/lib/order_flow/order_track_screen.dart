import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:green_oil_seekers/popups/feedback_popup.dart';

import '../home_screen/home_screen.dart';

class OrderTrackScreen extends StatefulWidget {
  final String orderId;
  final String oilType;
  final double qtyOil;
  final String companyName;
  final String arrivalDate;
  final String arrivalTime;

  const OrderTrackScreen({
    super.key,
    required this.orderId,
    required this.oilType,
    required this.qtyOil,
    required this.companyName,
    required this.arrivalDate,
    required this.arrivalTime,
    required String cityName,
  });

  @override
  State<StatefulWidget> createState() {
    return _OrderTrackScreenState();
  }
}

class _OrderTrackScreenState extends State<OrderTrackScreen> {
  bool feedbackGiven = false;

  void _showFeedbackPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FeedbackPopup(
          onClose: () => Navigator.of(context).pop(),
          onSend: (int rating) {
            setState(() {
              feedbackGiven = true;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order',
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
            _buildProcessingIndicator(),
            const SizedBox(height: 16),
            _buildOrderDetailsCard(),
            const SizedBox(height: 20),
            feedbackGiven ? _buildThankYouMessage() : _buildFeedbackButton(),
            const Spacer(),
            _buildBackToHomeButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProcessingIndicator() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).disabledColor,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.sync,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Processing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).disabledColor,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderDetailsCard() {
    return Container(
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
          _buildInfoRow('Order ID', widget.orderId, isOrderId: true),
          const Divider(),
          _buildInfoRow('Oil Type', widget.oilType),
          const Divider(),
          _buildInfoRow('QTY Oil', '${widget.qtyOil} L'),
          const Divider(),
          _buildInfoRow('Company Name', widget.companyName),
          const Divider(),
          _buildInfoRow('Estimated Arrival Date', widget.arrivalDate),
          const Divider(),
          _buildInfoRow('Estimated Arrival Time', widget.arrivalTime),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildInvoiceButton(),
              _buildKeepTrackButton(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackButton() {
    return GestureDetector(
      onTap: _showFeedbackPopup,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.feedback, color: Colors.white),
            const SizedBox(width: 8),
            Text(
              'Give Feedback',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThankYouMessage() {
    return Center(
      child: Text(
        'Thank you for your feedback!',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildBackToHomeButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'BACK TO HOME',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInvoiceButton() {
    return OutlinedButton(
      onPressed: () {
        // Code to generate and display invoice PDF
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(150, 45),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Invoice',
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildKeepTrackButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Code to track order using GPS functionality
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        minimumSize: const Size(150, 45),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        'Keep Track',
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isOrderId = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        if (isOrderId)
          Row(
            children: [
              Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.normal),
              ),
              const SizedBox(width: 4),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: value));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text("Order ID Copied"),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
                child: Icon(
                  Icons.copy,
                  size: 16,
                  color: Theme.of(context).disabledColor,
                ),
              ),
            ],
          )
        else
          Text(value),
      ],
    );
  }
}
