import 'package:flutter/material.dart';

Color getTextColor(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  return isDarkMode ? colorScheme.onPrimary : colorScheme.primary;
}
