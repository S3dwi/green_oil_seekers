import 'package:flutter/material.dart';

class RecycleButton extends StatelessWidget {
  const RecycleButton({
    super.key,
    required this.orderFlow,
  });

  final void Function() orderFlow;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        orderFlow();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        //shadow looks only apply horizontally, need to improve
        elevation: 6, // This adds the shadow
        shadowColor: Theme.of(context).shadowColor, // Shadow color
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 1),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Buy Used Oil Easily",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Explore offers and find used oil in seconds",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 16,
          ),
        ],
      ),
    );
  }
}
