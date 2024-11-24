import 'package:flutter/material.dart';

class PayButton extends StatelessWidget {
  const PayButton({
    super.key,
    required this.onPressed,
    required this.backgroundColor,
    required this.vertical,
    required this.horizontal,
    required this.child,
  });

  final void Function() onPressed;
  final Color backgroundColor;
  final double vertical;
  final double horizontal;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: backgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        //shadow looks only apply horizontally, need to improve
        elevation: 6, // This adds the shadow
        shadowColor: Theme.of(context).shadowColor, // Shadow color
      ),
      child: child,
    );
  }
}
