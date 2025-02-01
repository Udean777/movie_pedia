import 'package:flutter/material.dart';
import 'package:movie_pedia/presentation/profile/widgets/settings_tile.dart';

class SettingsCard extends StatelessWidget {
  const SettingsCard({
    super.key,
    required this.colorScheme,
  });

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          SettingsTile(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () {},
            colorScheme: colorScheme,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.security,
            title: 'Privacy',
            onTap: () {},
            colorScheme: colorScheme,
          ),
          const Divider(height: 1),
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}
