import 'package:flutter/material.dart';

// StatelessWidget that visually represents a step-by-step progress indicator.
class StepProgressIndicator extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const StepProgressIndicator({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment
          .center, // Centers the steps horizontally within the parent.
      children: List.generate(totalSteps, (index) {
        // Generates a list of widgets for each step.
        return Row(
          children: [
            Stack(
              alignment: Alignment
                  .center, // Centers the smaller circle within the larger one.
              children: [
                Container(
                  width: 15, // Outer circle width.
                  height: 15, // Outer circle height.
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Makes the container circular.
                    border: Border.all(
                      color: index <= currentStep
                          ? Theme.of(context)
                              .colorScheme
                              .primary // Color for completed or current steps.
                          : Theme.of(context)
                              .disabledColor, // Color for incomplete steps.
                      width: 2, // Border thickness.
                    ),
                  ),
                ),
                Container(
                  width: 7, // Inner circle width.
                  height: 7, // Inner circle height.
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Makes the container circular.
                    color: index <= currentStep
                        ? Theme.of(context)
                            .colorScheme
                            .primary // Color for completed or current steps.
                        : Theme.of(context)
                            .disabledColor, // Color for incomplete steps.
                  ),
                ),
              ],
            ),
            if (index <
                totalSteps -
                    1) // Checks if the current step is not the last step.
              Container(
                width: 50, // Width of the connecting line.
                height: 2, // Height of the connecting line.
                color: index < currentStep
                    ? Theme.of(context)
                        .colorScheme
                        .primary // Color for completed part of the line.
                    : Theme.of(context)
                        .disabledColor, // Color for incomplete part of the line.
              ),
          ],
        );
      }),
    );
  }
}
