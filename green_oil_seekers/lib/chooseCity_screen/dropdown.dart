import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const DropdownWidget({
    super.key,
    required this.selectedValue,
    required this.hint,
    required this.items,
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
        value: selectedValue,
        onChanged: onChanged,
        items: [
          ...items.map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                  color: selectedValue == item ? const Color(0xFF47AB4D) : Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
