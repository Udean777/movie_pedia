import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

class SearchTextField extends ConsumerWidget {
  final TextEditingController controller;

  const SearchTextField({required this.controller, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: controller,
      onChanged: (value) =>
          ref.read(searchQueryProvider.notifier).state = value,
      decoration: InputDecoration(
        hintText: 'Search movies...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
