// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class OilTypeSelection extends StatefulWidget {
  final ValueChanged<List<String>> onSelected;

  const OilTypeSelection({super.key, required this.onSelected});

  @override
  _OilTypeSelectionState createState() => _OilTypeSelectionState();
}

class _OilTypeSelectionState extends State<OilTypeSelection> {
  final List<String> oilTypes = [
    'Cooking Oil',
    'Motor Oil',
    'Lubricating Oil',
  ];
  List<String> selectedOilTypes = [];

  void _onOilTypeToggle(String oilType) {
    setState(() {
      if (selectedOilTypes.contains(oilType)) {
        selectedOilTypes.remove(oilType);
      } else {
        selectedOilTypes.add(oilType);
      }
    });
    widget.onSelected(selectedOilTypes);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children:
          oilTypes.map((oilType) => _buildOilTypeButton(oilType)).toList(),
    );
  }

  Widget _buildOilTypeButton(String oilType) {
    final isSelected = selectedOilTypes.contains(oilType);
    final colorScheme = Theme.of(context).colorScheme;

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
              : Theme.of(context)
                  .disabledColor, // Unselected: gray, Selected: primary
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
  }
}
