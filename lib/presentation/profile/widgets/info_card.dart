import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_pedia/presentation/profile/widgets/info_tile.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.colorScheme,
    required this.user,
  });

  final ColorScheme colorScheme;
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoTile(
              icon: Icons.email_outlined,
              title: 'Email',
              value: user?.email ?? 'Not available',
              colorScheme: colorScheme,
            ),
            const Divider(),
            InfoTile(
              icon: Icons.access_time,
              title: 'Member Since',
              value: user?.metadata.creationTime?.toString().split(' ')[0] ??
                  'Not available',
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}
