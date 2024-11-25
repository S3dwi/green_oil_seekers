import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/order_flow/payment_screen.dart';
import 'package:green_oil_seekers/order_flow/step_progress_indicator.dart';
import 'package:green_oil_seekers/primary_button.dart';

class OrderSummeryScreen extends StatelessWidget {
  const OrderSummeryScreen({
    super.key,
    required this.offer,
  });

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${offer.arrivalDate.day}/${offer.arrivalDate.month}/${offer.arrivalDate.year}';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 28),
            Text(
              "Order Summery",
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
              currentStep: 2,
              totalSteps: 4,
            ),
          ),
          const SizedBox(
            height: 12,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),

          Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.onPrimary,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailItem(
                    'Customer Name',
                    offer.customerInfo.companyName,
                    context,
                  ),
                  const Divider(),
                  buildDetailItem(
                    'Oil Type',
                    getOrderType(offer),
                    context,
                  ),
                  const Divider(),
                  buildDetailItem(
                    'Estimated Quantity',
                    '${offer.oilQuantity.toStringAsFixed(1)}L',
                    context,
                  ),
                  const Divider(),
                  buildDetailItem(
                    'Customer Location',
                    offer.location.city,
                    context,
                  ),
                  const Divider(),
                  buildDetailItem(
                    'Pickup Date',
                    formattedDate,
                    context,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payment Details',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
          Card(
            elevation: 2,
            color: Theme.of(context).colorScheme.onPrimary,
            margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildDetailItem(
                    'Oil Price',
                    'SAR ${offer.oilPrice}',
                    context,
                  ),
                  const Divider(),
                  buildDetailItem(
                    'Services',
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
                        Text(
                          'Total Payment',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        Text(
                          'SAR ${offer.oilPrice + 50}',
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
          PrimaryButton(
            onPressed: () {
              // Navigate to Payment Screen
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PaymentScreen(
                  offer: offer,
                ),
              ));
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'NEXT',
            vertical: 13,
            horizontal: 148.95,
          ),
          const SizedBox(
            height: 38,
          ),
        ],
      ),
    );
  }
}

String getOrderType(Offer offer) {
  if (offer.oilType == OilType.cookingOil) {
    return "Cooking Oil";
  } else if (offer.oilType == OilType.motorOil) {
    return "Motor Oil";
  } else if (offer.oilType == OilType.lubricating) {
    return "Lubricating Oil";
  } else {
    return "ERROR";
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
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    ),
  );
}
