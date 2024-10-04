import 'package:flutter/material.dart';

class OilTypeSelection extends StatefulWidget {
  const OilTypeSelection({super.key});
  @override
  State<StatefulWidget> createState() {
    return _OilTypeSelectionState();
  }
}

class _OilTypeSelectionState extends State<OilTypeSelection> {
  bool isCookingOilSelected = false;
  bool isMotorOilSelected = false;
  bool isLubricatingOilSelected = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildOilTypeButton('Cooking Oil', isCookingOilSelected, () {
          setState(() {
            isCookingOilSelected = !isCookingOilSelected;
          });
        }),
        buildOilTypeButton('Motor Oil', isMotorOilSelected, () {
          setState(() {
            isMotorOilSelected = !isMotorOilSelected;
          });
        }),
        buildOilTypeButton('Lubricating Oil', isLubricatingOilSelected, () {
          setState(() {
            isLubricatingOilSelected = !isLubricatingOilSelected;
          });
        }),
      ],
    );
  }

  Widget buildOilTypeButton(
      String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? const Color(0xFF47AB4D) : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
