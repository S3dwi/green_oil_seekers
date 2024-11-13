import 'package:flutter/material.dart';

class OilTypeSelection extends StatefulWidget {
  final List<String> oilTypes;
  final Function(List<String>) onSelected;
  final Color selectedColor;
  final Color unselectedColor;

  const OilTypeSelection({
    super.key,
    required this.onSelected,
    this.oilTypes = const ['Cooking Oil', 'Motor Oil', 'Lubricating Oil'],
    this.selectedColor = Colors.green,
    this.unselectedColor = Colors.grey,
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
        backgroundColor: isSelected ? Colors.grey[200] : Colors.transparent,
        side: BorderSide(
            color: isSelected ? widget.selectedColor : widget.unselectedColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? widget.selectedColor : Colors.black,
        ),
      ),
    );
  }
}
