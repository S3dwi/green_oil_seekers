import 'package:flutter/material.dart';

// A stateful widget to capture and submit user feedback.
class FeedbackPopup extends StatefulWidget {
  const FeedbackPopup({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _FeedbackPopupState();
  }
}

class _FeedbackPopupState extends State<FeedbackPopup> {
  int selectedRating = -1; // Stores the selected rating.
  bool isSendEnabled =
      false; // Determines if the "SEND" button should be enabled.
  TextEditingController feedbackController =
      TextEditingController(); // Controls the text input for feedback.

  @override
  void initState() {
    super.initState();
    // Add a listener to enable the SEND button based on input changes.
    feedbackController.addListener(_checkSendButtonStatus);
  }

  @override
  void dispose() {
    // Remove listener and dispose controller to avoid memory leaks.
    feedbackController.removeListener(_checkSendButtonStatus);
    feedbackController.dispose();
    super.dispose();
  }

  // Updates the state to enable or disable the SEND button.
  void _checkSendButtonStatus() {
    setState(() {
      isSendEnabled = selectedRating != -1 ||
          feedbackController.text
              .isNotEmpty; // Enable "SEND" if either a rating is selected or feedback is written.
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(15)), // Styling for the dialog's border.
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Give Feedback'), // Title of the dialog.
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog.
            },
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'How would you rate your experience with your service?',
            style: TextStyle(
                color: Color(0xFF737373)), // Styling for the prompt text.
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLeafIcon(0, 'assets/images/brown_leaf.png',
                  'POOR'), // Poor rating option.
              _buildLeafIcon(1, 'assets/images/yellow_leaf.png',
                  'GOOD'), // Good rating option.
              _buildLeafIcon(2, 'assets/images/green_leaf.png',
                  'EXCELLENT'), // Excellent rating option.
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Do you have any thoughts you’d like to share?',
            style: TextStyle(
                color: Colors.black), // Prompt for additional feedback.
          ),
          const SizedBox(height: 8),
          TextField(
            controller:
                feedbackController, // Text field for entering additional feedback.
            decoration: InputDecoration(
              hintText: 'The order was...',
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                    8), // Rounded corners for the text field.
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog without action.
          },
          child: const Text(
            'ASK ME LATER',
            style: TextStyle(color: Colors.green),
          ),
        ),
        ElevatedButton(
          onPressed:
              isSendEnabled ? () {} : null, // Enable if conditions are met.
          style: ElevatedButton.styleFrom(
            backgroundColor: isSendEnabled
                ? Colors.green
                : Colors.grey, // Change color based on enabled status.
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 50,
            ),
          ),
          child: const Text(
            'SEND',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }

  // Widget builder for the rating icons.
  Widget _buildLeafIcon(int rating, String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRating = rating; // Set the selected rating.
        });
        _checkSendButtonStatus(); // Update the SEND button status.
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 40,
            color: selectedRating == rating
                ? null
                : Colors.grey, // Color based on selection.
          ),
          const SizedBox(height: 4),
          Text(label,
              style:
                  const TextStyle(fontSize: 12)), // Label text for the rating.
        ],
      ),
    );
  }
}
