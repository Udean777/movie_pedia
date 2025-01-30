import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart'; // Pastikan Anda mengimpor Riverpod jika Anda menggunakannya

class LogoutDialog {
  static Future<void> show(BuildContext context, WidgetRef ref) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                ref.read(authServiceProvider).signOut();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
