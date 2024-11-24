import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  final String? selectedValue;
  final String hint;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool isCityDropdown;

  const DropdownWidget({
    super.key,
    required this.selectedValue,
    required this.hint,
    required this.items,
    required this.onChanged,
    this.isCityDropdown = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: colorScheme.secondary.withOpacity(0.24),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(
            hint,
            style: TextStyle(
              color: colorScheme.secondary.withOpacity(0.6),
            ),
          ),
          value: selectedValue,
          icon: Icon(Icons.expand_more, color: colorScheme.secondary),
          dropdownColor: colorScheme.onPrimary,
          items: _buildDropdownItems(context, colorScheme),
          onChanged: onChanged,
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> _buildDropdownItems(
      BuildContext context, ColorScheme colorScheme) {
    final List<DropdownMenuItem<String>> dropdownItems = [];

    if (isCityDropdown) {
      dropdownItems.add(
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
                    fontSize: 20),
              ),
              Divider(color: colorScheme.secondary.withOpacity(0.5)),
            ],
          ),
        ),
      );
    }

    dropdownItems.addAll(
      items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              item,
              style: TextStyle(
                color: selectedValue == item
                    ? colorScheme.primary
                    : colorScheme.secondary,
              ),
            ),
          ),
        );
      }).toList(),
    );

    return dropdownItems;
  }
}
