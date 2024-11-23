import 'package:flutter/material.dart';

class AddressSelector extends StatelessWidget {
  final List<String> savedAddresses;
  final Function(String) onAddressSelected;
  final VoidCallback onAddNewAddress;

  const AddressSelector({
    Key? key,
    required this.savedAddresses,
    required this.onAddressSelected,
    required this.onAddNewAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose your delivery address',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: savedAddresses.length,
              itemBuilder: (context, index) {
                final address = savedAddresses[index];
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(address),
                  onTap: () {
                    onAddressSelected(address);
                  },
                );
              },
            ),
          ),
          const Divider(),
          TextButton.icon(
            onPressed: onAddNewAddress,
            icon: const Icon(Icons.add, color: Colors.green),
            label: const Text(
              'Add New Address',
              style: TextStyle(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
