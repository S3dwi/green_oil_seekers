import 'package:flutter/material.dart';

// StatelessWidget that presents a confirmation screen to the user indicating that an email has been sent.
class SendEmailScreen extends StatelessWidget {
  const SendEmailScreen({
    super.key,
    required this.text, // Button text.
    required this.onPressed, // Function to execute when the button is pressed.
  });

  final String text;
  final void Function()
      onPressed; // Callback function that is called when the button is tapped.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20, // Horizontal padding.
          vertical: 10, // Vertical padding.
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment
              .center, // Centers the column vertically within the container.
          children: [
            Image.asset(
              "assets/images/email.png", // Email icon to visually represent the action.
              height: 200, // Sets the height of the image.
            ),
            const SizedBox(height: 40), // Spacer.
            Text(
              'Please check your email for reset password link.', // Instructions for the user.
              style: TextStyle(
                fontSize: 20, // Font size.
                fontWeight: FontWeight.bold, // Font weight.
                color: Theme.of(context).colorScheme.secondary, // Font color.
              ),
              textAlign: TextAlign.center, // Center the text.
            ),
            const SizedBox(height: 40), // Spacer.
            TextButton(
              onPressed:
                  onPressed, // Function to call when the button is tapped.
              child: Text(
                text, // Text to display on the button.
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surface, // Text color.
                  fontSize: 22, // Font size.
                  fontWeight: FontWeight.w600, // Font weight.
                  decoration: TextDecoration.underline, // Underline decoration.
                  decorationColor: Theme.of(context)
                      .colorScheme
                      .primary, // Decoration color.
                  shadows: [
                    Shadow(
                      color: Theme.of(context)
                          .colorScheme
                          .primary, // Shadow color.
                      offset: const Offset(
                          0, -5), // Vertical offset for the shadow.
                    ),
                  ],
                  decorationThickness: 1.5, // Thickness of the underline.
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
