import 'package:flutter/material.dart';

// StatelessWidget to display a help center card that users can tap to get help.
class HelpCenter extends StatelessWidget {
  const HelpCenter({
    super.key,
    required this.onTap, // Callback function for when the card is tapped.
  });

  final void Function() onTap; // The function to execute on tap.

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 375, // Fixed width of the card.
      height: 85, // Fixed height of the card.
      child: InkWell(
        onTap: onTap, // Function to call when the card is tapped.
        borderRadius: BorderRadius.circular(
            16), // Rounded corners of the InkWell for a smoother UI.
        child: Card(
          elevation: 4, // Elevation to give the card a raised look.
          shadowColor: Theme.of(context)
              .shadowColor, // Color of the shadow cast by the card.
          color: Theme.of(context)
              .colorScheme
              .onPrimary, // Background color of the card from the theme.
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16, // Horizontal padding inside the card.
              vertical: 12, // Vertical padding inside the card.
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Aligns the text to the start of the column.
                  children: [
                    Text(
                      "Help Center", // Main text label.
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Makes the label bold.
                        fontSize: 16, // Font size of the label.
                        color: Theme.of(context)
                            .colorScheme
                            .secondary, // Color of the text from the theme.
                      ),
                    ),
                    const SizedBox(
                      height: 2, // Spacing between the title and subtitle.
                    ),
                    Text(
                      "Don’t hesitate to reach us!", // Subtitle text.
                      style: TextStyle(
                        color: Theme.of(context)
                            .disabledColor, // Color for the subtitle text.
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Spacer to push the icon to the far right.
                Icon(
                  Icons.arrow_forward_ios, // Icon indicating navigation.
                  size: 15, // Size of the icon.
                  color: Theme.of(context)
                      .colorScheme
                      .secondary, // Color of the icon.
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
