import 'package:flutter/material.dart';

class AddressSelector extends StatelessWidget {
  final List<String> savedAddresses;
  final Function(String) onAddressSelected;
  final VoidCallback onAddNewAddress;
  final Function(String) onDeleteAddress;

  const AddressSelector({
    Key? key,
    required this.savedAddresses,
    required this.onAddressSelected,
    required this.onAddNewAddress,
    required this.onDeleteAddress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Choose your delivery address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: savedAddresses.length,
              itemBuilder: (context, index) {
                final address = savedAddresses[index];
                return ListTile(
                  leading: Theme(
                    data: Theme.of(context).copyWith(
                      iconTheme: const IconThemeData(
                        color: Color(0xFF47AB4D), // Custom green color
                      ),
                    ),
                    child: const Icon(Icons.location_on),
                  ),
                  title: Text(
                    address,
                    style: const TextStyle(fontSize: 14),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete,
                        color: Colors.red), // Red garbage icon
                    onPressed: () {
                      onDeleteAddress(address); // Trigger delete callback
                    },
                  ),
                  onTap: () {
                    onAddressSelected(address); // Trigger address selection
                  },
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(), // Line between items
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onAddNewAddress,
            icon: const Icon(Icons.add, color: Color(0xFF47AB4D)),
            label: const Text(
              'Add New Address',
              style: TextStyle(color: Color(0xFF47AB4D)),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF47AB4D)), // Green border
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
              ),
            ),
          ),
        ],
      ),
    );
  }
}
