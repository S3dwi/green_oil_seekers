// import 'package:flutter/material.dart';

// class PrimaryButton extends StatelessWidget {
//   const PrimaryButton({
//     super.key,
//     required this.onPressed,
//     required this.backgroundColor,
//     required this.label,
//     required this.vertical,
//     required this.horizontal,
//   });

//   final void Function() onPressed;
//   final Color backgroundColor;
//   final String label;
//   final double vertical;
//   final double horizontal;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         backgroundColor: backgroundColor,
//         padding: EdgeInsets.symmetric(
//           vertical: vertical,
//           horizontal: horizontal,
//         ),
//         //shadow looks only apply horizontally, need to improve
//         elevation: 6, // This adds the shadow
//         shadowColor: Theme.of(context).shadowColor, // Shadow color
//       ),
//       child: Text(
//         label,
//         style: TextStyle(
//           fontSize: 24,
//           fontWeight: FontWeight.bold,
//           color: Theme.of(context).colorScheme.onSecondary,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.verticalPadding = 20.0,
    this.horizontalPadding = 30.0,
    this.fontSize = 18.0,
    this.isEnabled = true,
  }) : super(key: key);

  final String label;
  final void Function() onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double verticalPadding;
  final double horizontalPadding;
  final double fontSize;
  final bool isEnabled;

  // Rest of the code remains the same

  @override
  Widget build(BuildContext context) {
    final Color resolvedBackgroundColor = isEnabled
        ? backgroundColor ?? Theme.of(context).colorScheme.primary
        : Theme.of(context).disabledColor;
    final Color resolvedTextColor = textColor ??
        (isEnabled
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSecondary);

    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: resolvedBackgroundColor,
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        elevation: isEnabled ? 6 : 0,
        shadowColor:
            isEnabled ? Theme.of(context).shadowColor : Colors.transparent,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: resolvedTextColor,
        ),
      ),
    );
  }
}
