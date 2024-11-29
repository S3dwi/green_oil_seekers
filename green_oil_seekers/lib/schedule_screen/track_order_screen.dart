import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';
import 'package:green_oil_seekers/nav_bar.dart';
import 'package:green_oil_seekers/primary_button.dart';
import 'package:green_oil_seekers/schedule_screen/vertical.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({
    super.key,
    required this.offer,
  });

  final Offer offer;

  @override
  State<StatefulWidget> createState() {
    return _TrackOrderScreenState();
  }
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  int _currentStep = 0; // Default to the initial step.

  final List<String> stepLabels = [
    "Order Placed",
    "Pickup Scheduled",
    "Order Completed",
  ];

  final List<String> stepSubtitles = [
    "Your order is being processed.",
    "Your order is scheduled for pickup.",
    "Your order is complete.",
  ];

  @override
  void initState() {
    super.initState();
    _currentStep = mapOrderStatusToStep(
        widget.offer.orderStatus.name); // Map the order status to a step
    _fetchCurrentStep(); // Fetch the current step from the database.
  }

  int mapOrderStatusToStep(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return 0;
      case 'pickupscheduled':
        return 1;
      case 'completed':
        return 2;
      default:
        return 0; // Default step for unknown statuses
    }
  }

  // fetch the current step from the database
  Future<void> _fetchCurrentStep() async {
    try {
      final databaseRef = FirebaseDatabase.instance.ref('requests');
      final snapshot = await databaseRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);

        data.forEach((userId, userRequests) {
          final userRequestMap = Map<String, dynamic>.from(userRequests as Map);

          userRequestMap.forEach((orderId, requestDetails) {
            if (orderId == widget.offer.orderID) {
              final requestMap =
                  Map<String, dynamic>.from(requestDetails as Map);

              // Map the current status to a step
              final orderStatus = requestMap['order Status'];
              int step = _mapStatusToStep(orderStatus);

              setState(() {
                _currentStep = step; // Update the current step.
              });
            }
          });
        });
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred while fetching the current step: $error",
            ),
          ),
        );
      }
    }
  }

  int _mapStatusToStep(String status) {
    switch (status) {
      case "pickupscheduled":
        return 1;
      case "completed":
        return 2;
      default:
        return 0; // Default to "Order Placed".
    }
  }

  void _onStepTapped(int step) {
    if (step == _currentStep + 1) {
      _showConfirmationDialog(step);
    }
  }

  // show a confirmation dialog before proceeding to the next step
  void _showConfirmationDialog(int step) {
    showDialog(
      context: context,
      builder: (context) {
        final colorScheme = Theme.of(context).colorScheme;
        return AlertDialog(
          backgroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            'Confirm Step',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colorScheme.primary,
            ),
          ),
          content: Text(
            'Are you sure you want to proceed to this step?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: colorScheme.secondary,
            ),
          ),
          actions: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentStep = step; // Update step locally.
                      });
                      Navigator.pop(context); // Close the dialog.
                      _updateOrderStat(step); // Update the database.
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                        width: 1.5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'NOT SURE',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  // Update the order status in the database.
  void _updateOrderStat(int step) async {
    try {
      String newStatus;
      switch (step) {
        case 1:
          newStatus = "pickupscheduled";
          break;
        case 2:
          newStatus = "completed";
          break;
        default:
          newStatus = "pending"; // Default status for unknown steps
      }

      final databaseRef = FirebaseDatabase.instance.ref('requests');
      final snapshot = await databaseRef.get();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);

        data.forEach((userId, userRequests) {
          final userRequestMap = Map<String, dynamic>.from(userRequests as Map);

          userRequestMap.forEach((orderId, requestDetails) async {
            if (orderId == widget.offer.orderID) {
              final orderRef = databaseRef.child('$userId/$orderId');

              // Update the order status
              await orderRef.update({
                'order Status': newStatus,
              });
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Order status updated to $newStatus",
                    ),
                  ),
                );
              }
            }
          });
        });
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "An error occurred while updating the order status: $error",
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            const SizedBox(height: 37),
            Text(
              "Track Order",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 30,
            color: colorScheme.secondary,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Order ID: ${widget.offer.orderID.substring(widget.offer.orderID.length - 10)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: colorScheme.secondary,
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Divider(),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Vertical(
              currentStep: _currentStep,
              stepLabels: stepLabels,
              stepSubtitles: stepSubtitles,
              onStepTapped: _onStepTapped,
            ),
          ),
          const Spacer(),
          PrimaryButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NavBar(wantedPage: 0),
                ),
              );
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            label: 'Back To Home',
            vertical: 13,
            horizontal: 90,
          ),
          const SizedBox(
            height: 38,
          ),
        ],
      ),
    );
  }
}
