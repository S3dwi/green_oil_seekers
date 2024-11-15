import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool isCityDropdown;

  const DropdownWidget({
    Key? key,
    required this.selectedValue,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.isCityDropdown = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary, // White background
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.24),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(color: colorScheme.secondary.withOpacity(0.6)),
          ),
          value: selectedValue,
          icon: Icon(Icons.expand_more, color: colorScheme.secondary),
          dropdownColor:
              colorScheme.onPrimary, // Ensures dropdown background is white
          items: [
            if (isCityDropdown)
              DropdownMenuItem<String>(
                enabled: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find City",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                    Divider(color: colorScheme.secondary.withOpacity(0.5)),
                  ],
                ),
              ),
            ...items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  color: Colors.transparent, // No background on hover
                  child: Text(
                    item,
                    style: TextStyle(
                      color: selectedValue == item
                          ? colorScheme.secondary
                          : colorScheme.secondary, // Selected item stays black
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
