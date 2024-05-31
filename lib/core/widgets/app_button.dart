import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String title;
  final Function() onPressed;

  const AppButton({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return
      ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            minimumSize: const Size(double.infinity, 50)),
        onPressed: onPressed,
        child: Text(
          title,
          style: textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 19),
        ),
      )
      ;
  }
}
