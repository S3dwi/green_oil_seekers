import 'package:flutter/material.dart';

// StatelessWidget that renders a card for displaying account details such as label and value.
class AccountDetailCard extends StatelessWidget {
  // Constructor with required parameters for label and value.
  const AccountDetailCard({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 85,
      child: Card(
        elevation: 4, // Shadow depth indicating how raised the card appears.
        shadowColor: Theme.of(context).shadowColor,
        color: Theme.of(context)
            .colorScheme
            .onPrimary, // Background color of the card from theme.
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Aligns children to the start of the cross axis.
            children: [
              Text(
                label, // Displays the label.
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(
                height: 2, // Spacing between label and value.
              ),
              Text(
                value, // Displays the value.
                style: TextStyle(
                  color: Theme.of(context)
                      .disabledColor, // Color of the value text (less emphasis).
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
