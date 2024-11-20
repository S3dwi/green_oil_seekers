import 'package:flutter/material.dart';

class OilTypeSelection extends StatefulWidget {
  final ValueChanged<List<String>> onSelected;
  final List<String> selectedOilTypes;

  const OilTypeSelection({
    super.key,
    required this.onSelected,
    required this.selectedOilTypes,
  });

  @override
  _OilTypeSelectionState createState() => _OilTypeSelectionState();
}

class _OilTypeSelectionState extends State<OilTypeSelection> {
  final List<String> oilTypes = [
    'Cooking Oil',
    'Motor Oil',
    'Lubricating Oil',
  ];

  // Update the selectedOilTypes list based on user selection
  void _onOilTypeToggle(String oilType) {
    setState(() {
      if (widget.selectedOilTypes.contains(oilType)) {
        widget.selectedOilTypes.remove(oilType);
      } else {
        widget.selectedOilTypes.add(oilType);
      }
    });
    widget
        .onSelected(widget.selectedOilTypes); // Pass the updated selection back
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 8.0,
      children: oilTypes.map((oilType) {
        final isSelected = widget.selectedOilTypes.contains(oilType);
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor:
                isSelected ? colorScheme.primary : colorScheme.secondary,
            backgroundColor: isSelected
                ? colorScheme.onPrimary.withOpacity(0.2)
                : colorScheme.onPrimary,
            side: BorderSide(
              color: isSelected
                  ? colorScheme.primary
                  : Theme.of(context).disabledColor,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => _onOilTypeToggle(oilType),
          child: Text(
            oilType,
            style: TextStyle(
              color: isSelected ? colorScheme.primary : colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }).toList(),
    );
  }
}
