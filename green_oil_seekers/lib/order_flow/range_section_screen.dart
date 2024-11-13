import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RangeSection extends StatefulWidget {
  final String title;
  final String unit;
  final double min;
  final double max;
  final Function(double, double)? onRangeSelected;

  const RangeSection({
    super.key,
    required this.title,
    required this.unit,
    required this.min,
    required this.max,
    this.onRangeSelected,
  });

  @override
  State<StatefulWidget> createState() {
    return _RangeSectionState();
  }
}

class _RangeSectionState extends State<RangeSection> {
  late TextEditingController minController;
  late TextEditingController maxController;

  @override
  void initState() {
    super.initState();
    minController = TextEditingController();
    maxController = TextEditingController();
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: minController,
                decoration: InputDecoration(
                  hintText: 'Min ${widget.unit}',
                  suffixText: widget.unit,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (value) => _onRangeChanged(),
              ),
            ),
            const SizedBox(width: 16),
            const Text('to'),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: maxController,
                decoration: InputDecoration(
                  hintText: 'Max ${widget.unit}',
                  suffixText: widget.unit,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                onChanged: (value) => _onRangeChanged(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
