import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

class HomeTabBar extends StatelessWidget {
  final WidgetRef ref;

  const HomeTabBar({required this.ref, super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: const EdgeInsets.symmetric(horizontal: 12),
      onTap: (index) {
        final categories = ["now_playing", "upcoming", "top_rated", "popular"];
        ref.read(selectedCategoryProvider.notifier).state = categories[index];
      },
      tabs: const [
        Tab(text: "Now Playing"),
        Tab(text: "Upcoming"),
        Tab(text: "Top Rated"),
        Tab(text: "Popular"),
      ],
    );
  }
}
