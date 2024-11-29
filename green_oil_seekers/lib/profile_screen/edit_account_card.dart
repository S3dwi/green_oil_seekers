import 'package:flutter/material.dart';

// StatelessWidget for creating an editable text field within a card for account settings.
class EditAccountCard extends StatelessWidget {
  const EditAccountCard({
    super.key,
    required this.label, // The text label for the text field.
    required this.value, // The initial value shown in the text field.
    required this.maxLength, // The maximum length of the text allowed in the text field.
    required this.keyboardType, // The type of keyboard layout to use.
    required this.controller, // Controller for the text field to manage text editing.
  });

  final String label;
  final String value;
  final int maxLength;
  final TextInputType keyboardType;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 146,
      child: Card(
        elevation: 4, // Shadow depth to elevate the card visually.
        shadowColor: Theme.of(context)
            .shadowColor, // Color of the shadow cast by the card.
        color: Theme.of(context).colorScheme.onPrimary,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Align children to the start of the cross axis.
            children: [
              Text(
                label, // Displays the label above the text field.
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(
                height:
                    5, // Adds a small space between the label and the text field.
              ),
              TextField(
                controller:
                    controller, // Assigns the text controller to the text field.
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                maxLength:
                    maxLength, // Limits the number of characters that can be entered.
                keyboardType:
                    keyboardType, // Sets the type of keyboard that appears.
                decoration: InputDecoration(
                  hintText:
                      value, // Displays a hint text that shows the initial value.
                  floatingLabelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimary, // Error border color.
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  fillColor: Theme.of(context).colorScheme.onPrimary,
                  filled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
