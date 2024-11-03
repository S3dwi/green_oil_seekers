import 'package:flutter/material.dart';

class FeedbackPopup extends StatefulWidget {
  final VoidCallback onClose;
  final ValueChanged<int> onSend;

  const FeedbackPopup({
    Key? key,
    required this.onClose,
    required this.onSend,
  }) : super(key: key);

  @override
  _FeedbackPopupState createState() => _FeedbackPopupState();
}

class _FeedbackPopupState extends State<FeedbackPopup> {
  int selectedRating = -1;
  bool isSendEnabled = false; // Track if the "SEND" button should be enabled
  TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    super.initState();
    feedbackController.addListener(_checkSendButtonStatus);
  }

  @override
  void dispose() {
    feedbackController.removeListener(_checkSendButtonStatus);
    feedbackController.dispose();
    super.dispose();
  }

  void _checkSendButtonStatus() {
    setState(() {
      // Enable "SEND" if either a rating is selected or feedback is written
      isSendEnabled =
          selectedRating != -1 || feedbackController.text.isNotEmpty;
    });
  }

  void _submitFeedback() {
    if (isSendEnabled) {
      widget.onSend(selectedRating);
      Navigator.of(context).pop(); // Close the dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Give Feedback'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: widget.onClose,
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'How would you rate your experience with your service?',
            style: TextStyle(color: Color(0xFF737373)),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLeafIcon(0, 'assets/images/brown_leaf.png', 'POOR'),
              _buildLeafIcon(1, 'assets/images/yellow_leaf.png', 'GOOD'),
              _buildLeafIcon(2, 'assets/images/green_leaf.png', 'EXCELLENT'),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Do you have any thoughts you’d like to share?',
            style: TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: feedbackController,
            decoration: InputDecoration(
              hintText: 'The order was...',
              hintStyle: const TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: widget.onClose,
          child: const Text(
            'ASK ME LATER',
            style: TextStyle(color: Colors.green),
          ),
        ),
        ElevatedButton(
          onPressed: isSendEnabled
              ? _submitFeedback
              : null, // Enable if conditions are met
          style: ElevatedButton.styleFrom(
            backgroundColor: isSendEnabled
                ? Colors.green
                : Colors.grey, // Change color based on enabled status
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

  Widget _buildLeafIcon(int rating, String imagePath, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRating = rating;
        });
        _checkSendButtonStatus();
      },
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 40,
            color: selectedRating == rating ? null : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
