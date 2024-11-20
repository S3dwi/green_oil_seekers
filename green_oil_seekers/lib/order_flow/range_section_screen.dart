import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RangeSection extends StatefulWidget {
  final String title;
  final String unit;
  final double min;
  final double max;
  final Function(double, double)? onRangeSelected;
  final TextStyle? titleStyle; // Custom title style

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
  late TextEditingController minController;
  late TextEditingController maxController;

  @override
  void initState() {
    super.initState();
    minController = TextEditingController(text: widget.min.toString());
    maxController = TextEditingController(text: widget.max.toString());
  }

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  void _onRangeChanged() {
    final minVal = double.tryParse(minController.text) ?? widget.min;
    final maxVal = double.tryParse(maxController.text) ?? widget.max;

    if (minVal <= maxVal) {
      widget.onRangeSelected?.call(minVal, maxVal);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: widget.titleStyle ??
              TextStyle(
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
              onChanged: (value) => _onRangeChanged(),
            ),
            const SizedBox(width: 10),
            Text(
              'to',
              style: TextStyle(
                color: colorScheme.secondary,
                fontSize: 20,
              ),
            ),
            const SizedBox(width: 10),
            _buildTextField(
              controller: maxController,
              hintText: 'Max ${widget.unit}',
              onChanged: (value) => _onRangeChanged(),
            ),
          ],
        ),
      ],
    );
  }

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
          hintText: hintText,
          suffixText: widget.unit,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          hintStyle: TextStyle(
            color: Theme.of(context).disabledColor,
          ),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
        ],
        onChanged: onChanged,
        style: TextStyle(
          color: colorScheme.secondary,
        ),
        onTap: () {
          // Select all text when the field is focused
          controller.selection = TextSelection(
            baseOffset: 0,
            extentOffset: controller.text.length,
          );
        },
      ),
    );
  }
}
