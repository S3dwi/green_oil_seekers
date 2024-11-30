import 'package:flutter/material.dart';

class RecycleButton extends StatelessWidget {
  // Constructor for the RecycleButton widget with a callback function for when the button is pressed.
  const RecycleButton({
    super.key,
    required this.orderFlow,
  });

  // Callback function that defines the action to perform when the button is clicked.
  final void Function() orderFlow;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        orderFlow(); // Execute the provided callback function on button press.
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16), // Rounded corners of the button.
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        elevation: 6,
        shadowColor: Theme.of(context).shadowColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Align children to the start and end of the row.
        children: [
          const SizedBox(width: 1), // A small horizontal spacer.
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.center, // Center align the texts vertically.
            children: [
              Text(
                "Buy Used Oil Easily", // Main text on the button.
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Explore offers and find used oil in seconds", // Subtext on the button.
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 15,
                  fontWeight:
                      FontWeight.w300, // Light font weight for the subtext.
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios, // Arrow icon indicating a forward action.
            color: Theme.of(context).colorScheme.onPrimary,
            size: 16,
          ),
        ],
      ),
    );
  }
}
