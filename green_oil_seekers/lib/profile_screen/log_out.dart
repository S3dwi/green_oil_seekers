import 'package:flutter/material.dart';

// StatelessWidget for creating a logout card which users can tap to log out.
class LogOut extends StatelessWidget {
  const LogOut({
    super.key,
    required this.onTap, // Callback function that gets called on tap.
  });

  final void Function() onTap; // Function to execute when the card is tapped.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375,
      height: 85,
      child: InkWell(
        onTap:
            onTap, // Triggers the provided onTap function when the card is tapped.
        borderRadius: BorderRadius.circular(16),
        child: Card(
          elevation: 4,
          shadowColor: Theme.of(context).shadowColor,
          color: Theme.of(context).colorScheme.onPrimary,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: Row(
              children: [
                Text(
                  "Log out", // Text displayed on the card.
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.logout,
                  size: 27,
                  color: Theme.of(context).colorScheme.error,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
