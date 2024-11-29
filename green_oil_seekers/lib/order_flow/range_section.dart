import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// StatefulWidget that allows users to select a range between two values.
class RangeSection extends StatefulWidget {
  final String title; // Title for the range section.
  final String unit; // Unit of measurement (e.g., liters, dollars).
  final double min; // Minimum value for the range.
  final double max; // Maximum value for the range.
  final Function(double, double)?
      onRangeSelected; // Callback when the range is selected.
  final TextStyle? titleStyle; // Custom style for the title.

  const RangeSection({
    super.key,
    required this.title,
    required this.unit,
    required this.min,
    required this.max,
    this.onRangeSelected,
    this.titleStyle,
  });

  @override
  State<StatefulWidget> createState() => _RangeSectionState();
}

class _RangeSectionState extends State<RangeSection> {
  late TextEditingController
      minController; // Controller for minimum value text field.
  late TextEditingController
      maxController; // Controller for maximum value text field.

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with initial values.
    minController = TextEditingController(text: widget.min.toString());
    maxController = TextEditingController(text: widget.max.toString());
  }

  @override
  void dispose() {
    // Dispose controllers to release resources.
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  // Handles the logic to update the range based on user input.
  void _onRangeChanged() {
    final minVal = double.tryParse(minController.text) ??
        widget.min; // Parse or fallback to widget.min.
    final maxVal = double.tryParse(maxController.text) ??
        widget.max; // Parse or fallback to widget.max.

    // Call the callback if the range is valid.
    if (minVal <= maxVal) {
      widget.onRangeSelected?.call(minVal, maxVal);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context)
        .colorScheme; // Accessing the color scheme from the theme.

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title, // Display the section title.
          style: widget.titleStyle ??
              TextStyle(
                // Apply custom or default styling.
                fontWeight: FontWeight.bold,
                color: colorScheme.secondary,
                fontSize: 16,
              ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _buildTextField(
              controller: minController,
              hintText: 'Min ${widget.unit}',
              onChanged: (value) =>
                  _onRangeChanged(), // Update range on change.
            ),
            const SizedBox(width: 10),
            Text(
              'to', // Literal string indicating range.
              style: TextStyle(
                color: colorScheme.secondary,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 10, height: 30),
            _buildTextField(
              controller: maxController,
              hintText: 'Max ${widget.unit}',
              onChanged: (value) =>
                  _onRangeChanged(), // Update range on change.
            ),
          ],
        ),
      ],
    );
  }

  // Builds a text field for entering numeric values.
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Function(String) onChanged,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText, // Hint text displaying minimum or maximum.
          suffixText:
              widget.unit, // Unit displayed as suffix in the input field.
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(8), // Rounded corners for the text field.
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).disabledColor, // Hint text color.
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(
            decimal: true), // Number input with decimal.
        inputFormatters: [
          FilteringTextInputFormatter.allow(
              RegExp(r'^\d*\.?\d*')), // Allow only decimal numbers.
        ],
        onChanged: onChanged,
        style: TextStyle(
          color: colorScheme.secondary, // Text color.
        ),
        onTap: () {
          // Select all text when the field is focused.
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        },
      ),
    );
  }
}
