import 'package:flutter/material.dart';

class TrackOrderScreen extends StatefulWidget {
  final String orderId;

  const TrackOrderScreen({super.key, required this.orderId});

  @override
  State<StatefulWidget> createState() {
    return _TrackOrderScreenState();
  }
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Order',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: colorScheme.secondary),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Image.asset(
              'assets/images/GreenOilLogo.png',
              width: 30,
              height: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Order ID: ${widget.orderId}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Stepper(
                currentStep: _currentStep,
                onStepTapped: (step) {
                  setState(() {
                    _currentStep = step;
                  });
                },
                controlsBuilder: (context, _) => const SizedBox.shrink(),
                steps: _buildSteps(colorScheme),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'BACK TO ORDER',
                style: TextStyle(color: colorScheme.onPrimary, fontSize: 20),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  List<Step> _buildSteps(ColorScheme colorScheme) {
    final steps = [
      {
        'title': 'Order Placed',
        'content':
            'Your order is being processed, once accepted you can move further.',
      },
      {
        'title': 'Order Accepted',
        'content': 'Your order has been accepted by a provider.',
      },
      {
        'title': 'Pickup Scheduled',
        'content': 'Your order is scheduled for pickup on the selected date.',
      },
      {
        'title': 'Pickup Confirmed',
        'content': 'Your pickup is scheduled for the chosen date.',
      },
      {
        'title': 'Order Completed',
        'content': 'Your order is complete. The used oil has been picked up.',
      },
    ];

    return steps.asMap().entries.map((entry) {
      final index = entry.key;
      final step = entry.value;

      return Step(
        title: Text(
          step['title']!,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _currentStep >= index
                ? colorScheme.primary
                : colorScheme.secondary,
          ),
        ),
        content: Text(
          step['content']!,
          style: TextStyle(
            fontSize: 16,
            color: _currentStep >= index
                ? colorScheme.primary
                : Theme.of(context).disabledColor,
          ),
        ),
        isActive: _currentStep >= index,
        state: _currentStep > index ? StepState.complete : StepState.indexed,
      );
    }).toList();
  }
}
