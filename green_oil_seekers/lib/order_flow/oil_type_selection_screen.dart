import 'package:flutter/material.dart';

class OilTypeSelection extends StatefulWidget {
  final ValueChanged<List<String>> onSelected;

  const OilTypeSelection({super.key, required this.onSelected});

  @override
  _OilTypeSelectionState createState() => _OilTypeSelectionState();
}

class _OilTypeSelectionState extends State<OilTypeSelection> {
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
      children: [
        _buildOilTypeButton('Cooking Oil'),
        _buildOilTypeButton('Motor Oil'),
        _buildOilTypeButton('Lubricating Oil'),
      ],
    );
  }

  Widget _buildOilTypeButton(String oilType) {
    final isSelected = selectedOilTypes.contains(oilType);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Color(0xFF448E49),
        backgroundColor: isSelected ? Color(0xFFD9D9D9) : Colors.white,
        side: BorderSide(
          color: isSelected ? Color(0xFF448E49) : Colors.grey,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: TextStyle(
          color: isSelected ? Color(0xFF448E49) : Colors.black,
        ),
      ),
      onPressed: () => _onOilTypeToggle(oilType),
      child: Text(oilType),
    );
  }
}
