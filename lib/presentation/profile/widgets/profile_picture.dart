import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.secondaryContainer,
        border: Border.all(
          color: colorScheme.primary,
          width: 3,
        ),
      ),
      child: Icon(
        Icons.person,
        size: 60,
        color: colorScheme.onSecondaryContainer,
      ),
    );
  }
}
