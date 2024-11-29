import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:green_oil_seekers/models/offer.dart';

class LacationItem extends StatefulWidget {
  // Constructor to create a LocationItem widget with necessary parameters.
  const LacationItem({
    super.key,
    required this.location,
    required this.index,
    required this.onDelete,
    required this.onSelect,
  });

  final Location location;
  final int index;
  final VoidCallback onDelete;
  final VoidCallback onSelect;

  @override
  State<StatefulWidget> createState() {
    return _LacationItemState();
  }
}

class _LacationItemState extends State<LacationItem> {
  // Method to delete a location from Firestore and the local list.
  void _deleteLocation(int index) async {
    final userId =
        FirebaseAuth.instance.currentUser?.uid; // Get the current user's ID.
    if (userId != null) {
      try {
        final firestore = FirebaseFirestore.instance;
        final userRef = firestore.collection('seeker').doc(userId);
        final doc = await userRef.get();

        if (doc.exists && doc.data() != null) {
          // Retrieves the saved locations from Firestore, removes the one at the specified index, then updates Firestore.
          var currentLocations = List<Map<String, dynamic>>.from(
              doc.data()!['savedLocations'] as List);
          if (index >= 0 && index < currentLocations.length) {
            currentLocations.removeAt(index);
            await userRef.update({'savedLocations': currentLocations});
            widget
                .onDelete(); // Invoke the deletion callback after successful removal.
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting location: $e'),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 5,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: widget
                      .onSelect, // Trigger the select callback when tapped.
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 34,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: Text(
                          widget.location
                              .toString(), // Display the location as a string.
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  _deleteLocation(widget
                      .index); // Call delete method when the delete icon is pressed.
                },
                icon: Icon(
                  Icons.delete,
                  size: 34,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
          const Divider(),
        ],
      ),
    );
  }
}
