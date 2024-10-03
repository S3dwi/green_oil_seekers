import 'package:flutter/material.dart';

class RangeSection extends StatefulWidget {
  final String title;
  final String unit;
  final double min;
  final double max;

  const RangeSection({
    required this.title,
    required this.unit,
    required this.min,
    required this.max,
  });

  @override
  _RangeSectionState createState() => _RangeSectionState();
}

class _RangeSectionState extends State<RangeSection> {
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _minController.text = ''; // Start with empty text for min
    _maxController.text = ''; // Start with empty text for max
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildRangeInputField(
              controller: _minController,
              hint: widget.min.toStringAsFixed(2), // Placeholder for min value
              unit: widget.unit,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0), // Padding for both sides
              child: Text(
                'to',
                style: TextStyle(fontSize: 20), // Adjust the font size here
              ),
            ),
            buildRangeInputField(
              controller: _maxController,
              hint: widget.max.toStringAsFixed(2), // Placeholder for max value
              unit: widget.unit,
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRangeInputField({
    required TextEditingController controller,
    required String hint,
    required String unit,
  }) {
    return Expanded(
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint, // Placeholder text
          suffixText: unit,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onTap: () {
          if (controller.text == hint) {
            controller
                .clear(); // Clear text when clicked if placeholder is still there
          }
        },
      ),
    );
  }
}
