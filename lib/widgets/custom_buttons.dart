import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonPrimary({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      //   foregroundColor: textColor ?? Colors.white,
      //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      //   shape: RoundedRectangleBorder(
      //      borderRadius: BorderRadius.circular(12),
      //   ),
      //   textStyle: const TextStyle(
      //     fontSize: 16,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const ButtonSecondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // style: ElevatedButton.styleFrom(
      //   backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
      //   foregroundColor: textColor ?? Colors.white,
      //   padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(12),
      //   ),
      //   textStyle: const TextStyle(
      //     fontSize: 16,
      //     fontWeight: FontWeight.bold,
      //   ),
      // ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
