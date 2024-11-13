import 'package:flutter/material.dart';

class LastOrderButton extends StatelessWidget {
  const LastOrderButton({
    super.key,
    required this.lastOrder,
  });

  final void Function() lastOrder;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        lastOrder();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        padding: const EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 15,
        ),
        //shadow looks only apply horizontally, need to improve
        elevation: 6, // This adds the shadow
        shadowColor: Theme.of(context).shadowColor, // Shadow color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'View Last Order',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 18,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).disabledColor,
          ),
        ],
      ),
    );
  }
}
