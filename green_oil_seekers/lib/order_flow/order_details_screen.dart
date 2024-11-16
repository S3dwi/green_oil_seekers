import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

import '../home_screen/home_screen.dart';
import '../primary_button.dart';
import 'invoice_screen.dart';
import 'track_order_screen.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String orderId;
  final String oilType;
  final int qtyOil;
  final String companyName;
  final String customerLocation;
  final String pickupDate;
  final String userEmail;

  final String invoiceId = Uuid().v4().substring(0, 8).toUpperCase();

  OrderDetailsScreen({
    Key? key,
    required this.orderId,
    required this.oilType,
    required this.qtyOil,
    required this.companyName,
    required this.customerLocation,
    required this.pickupDate,
    required this.userEmail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.sync, color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Processing',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    child: const Icon(Icons.headset_mic,
                        color: Colors.green, size: 20),
                  ),
                  onPressed: () {
                    // To be implemented: Navigate to customer service screen
                  },
                ),
              ],
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
                    _buildOrderIdRow(context),
                    _buildDivider(),
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
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InvoiceScreen(
                                    invoiceId: invoiceId,
                                    userEmail: userEmail,
                                    customerName: "Raef Shah",
                                    oilType: oilType,
                                    companyName: companyName,
                                    quantity: qtyOil,
                                    customerContactInfo: "RaefAshah@gmail.com",
                                    companyContactInfo: "JanBurger@gmail.com",
                                    dateOfIssue: DateTime.now(),
                                    orderId: orderId,
                                  ),
                                ),
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Invoice',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TrackOrderScreen(orderId: orderId),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Track Order',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: 'BACK TO HOME',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderIdRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Order ID', style: TextStyle(fontSize: 16)),
        Row(
          children: [
            Text(
              orderId.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: orderId));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Order ID copied')),
                );
              },
              child: const Icon(Icons.copy, size: 16, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }

  Divider _buildDivider() => Divider(color: Colors.grey.shade300);

  String _truncateLocation(String location) {
    return location.length > 25 ? '${location.substring(0, 25)}...' : location;
  }
}
