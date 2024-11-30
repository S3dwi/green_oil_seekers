import 'package:flutter/material.dart';

class LastOrderButton extends StatelessWidget {
  // Constructor for the LastOrderButton widget with a callback function.
  const LastOrderButton({
    super.key,
    required this.lastOrder,
  });

  final void Function() lastOrder;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        lastOrder(); // Execute the provided callback function on button press.
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(16), // Rounded corners of the button.
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 15,
        ),
        elevation: 6, // Elevation for a shadow effect.
        shadowColor: Theme.of(context).shadowColor, // Color of the shadow.
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween, // Align children in the row.
        children: [
          Text(
            'View Your Orders',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios, // Arrow icon indicating forward action.
            color: Theme.of(context).disabledColor,
          ),
        ],
      ),
    );
  }
}
