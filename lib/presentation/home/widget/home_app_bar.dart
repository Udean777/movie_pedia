import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/widgets/logout_dialog.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final WidgetRef ref;

  const HomeAppBar({required this.ref, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Movie Pedia',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: () => LogoutDialog.show(context, ref),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
