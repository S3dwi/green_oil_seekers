import 'package:flutter/material.dart';

class OilTypeSelection extends StatefulWidget {
  final List<String> oilTypes;
  final Function(List<String>) onSelected;

  const OilTypeSelection({
    super.key,
    required this.onSelected,
    this.oilTypes = const ['Cooking Oil', 'Motor Oil', 'Lubricating Oil'],
  });

  @override
  State<StatefulWidget> createState() {
    return _OilTypeSelectionState();
  }
}

class _OilTypeSelectionState extends State<OilTypeSelection> {
  List<String> selectedOilTypes = [];

  void toggleSelection(String oilType) {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widget.oilTypes.map((oilType) {
        return buildOilTypeButton(
          oilType,
          selectedOilTypes.contains(oilType),
          () => toggleSelection(oilType),
        );
      }).toList(),
    );
  }

  Widget buildOilTypeButton(
      String text, bool isSelected, VoidCallback onPressed) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.onPrimary.withOpacity(0.1)
            : Colors.transparent,
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).disabledColor,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
