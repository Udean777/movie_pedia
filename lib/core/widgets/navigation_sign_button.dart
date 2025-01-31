import 'package:flutter/material.dart';

class NavigationSignButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final String subText;

  const NavigationSignButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 16),
          children: [
            TextSpan(
              text: text,
              style: TextStyle(color: Colors.white70),
            ),
            TextSpan(
              text: subText,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
