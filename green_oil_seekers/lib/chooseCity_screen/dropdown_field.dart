import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String hint;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;

  DropdownField({
    required this.hint,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        hint: Text(hint),
        value: selectedItem,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(
                color: selectedItem == item
                    ? Color(0xFF47AB4D)
                    : Colors.black, // Green when selected
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
