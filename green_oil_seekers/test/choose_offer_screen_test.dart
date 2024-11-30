import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_oil_seekers/order_flow/choose_offer_screen.dart';
import 'package:green_oil_seekers/order_flow/step_progress_indicator.dart';

void main() {
  testWidgets('Verify Step Progress Indicator displays correctly', (WidgetTester tester) async {
    // Build the ChooseOfferScreen widget
    await tester.pumpWidget(
      const MaterialApp(
        home: ChooseOfferScreen(),
      ),
    );

    // Verify the StepProgressIndicator is present
    final stepProgressFinder = find.byType(StepProgressIndicator);
    expect(stepProgressFinder, findsOneWidget);

    // Verify the total number of steps and current step
    final stepProgressWidget = tester.widget<StepProgressIndicator>(stepProgressFinder);
    expect(stepProgressWidget.totalSteps, 4);
    expect(stepProgressWidget.currentStep, 0);
  });
}

//Explanation
// Purpose:

// Verifies the presence of the StepProgressIndicator in the ChooseOfferScreen.
// Checks its totalSteps and currentStep values.
// Steps:

// Build the ChooseOfferScreen widget.
// Use find.byType(StepProgressIndicator) to locate the progress indicator.
// Retrieve its properties using tester.widget and assert they are correct.
// Assertions:

// Ensures the progress indicator is rendered.
// Confirms the correct number of steps (totalSteps) and the current step (currentStep).