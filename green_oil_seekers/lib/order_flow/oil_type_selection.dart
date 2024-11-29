import 'package:flutter/material.dart';

// StatefulWidget that allows users to select oil types from a list of options.
class OilTypeSelection extends StatefulWidget {
  final ValueChanged<List<String>>
      onSelected; // Callback when selection changes.
  final List<String> selectedOilTypes; // Currently selected oil types.

  const OilTypeSelection({
    super.key,
    required this.onSelected, // Initializes the callback function.
    required this.selectedOilTypes, // Initializes the list of selected oil types.
  });

  @override
  State<StatefulWidget> createState() {
    return _OilTypeSelectionState();
  }
}

class _OilTypeSelectionState extends State<OilTypeSelection> {
  final List<String> oilTypes = [
    'Cooking Oil', // Different types of oils that can be selected.
    'Motor Oil',
    'Lubricating Oil',
  ];

  // Toggles the inclusion of an oil type in the selectedOilTypes list.
  void _onOilTypeToggle(String oilType) {
    setState(() {
      if (widget.selectedOilTypes.contains(oilType)) {
        widget.selectedOilTypes
            .remove(oilType); // Remove the oil type if it is already selected.
      } else {
        widget.selectedOilTypes
            .add(oilType); // Add the oil type if it is not selected.
      }
    });
    widget.onSelected(
        widget.selectedOilTypes); // Trigger the callback with updated list.
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Wrap(
      spacing: 14.0, // Horizontal space between buttons.
      runSpacing: 5, // Vertical space between buttons.
      children: oilTypes.map((oilType) {
        final isSelected = widget.selectedOilTypes
            .contains(oilType); // Check if oil type is selected.
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor:
                isSelected ? colorScheme.primary : colorScheme.secondary,
            backgroundColor: isSelected
                ? colorScheme.onPrimary.withOpacity(0.7)
                : colorScheme.onPrimary,
            side: BorderSide(
              color: isSelected
                  ? colorScheme.primary
                  : Theme.of(context).disabledColor,
              width: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(8), // Rounded corners for buttons.
            ),
            padding: const EdgeInsets.symmetric(horizontal: 34),
          ),
          onPressed: () =>
              _onOilTypeToggle(oilType), // Handle press to toggle selection.
          child: Text(
            oilType, // Display the oil type.
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
