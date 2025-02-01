import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

class HomeTabBar extends StatelessWidget {
  final WidgetRef ref;

  const HomeTabBar({required this.ref, super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        labelColor: colorScheme.onSurface,
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        indicator: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.all(4),
        onTap: (index) {
          final categories = [
            "now_playing",
            "upcoming",
            "top_rated",
            "popular"
          ];
          ref.read(selectedCategoryProvider.notifier).state = categories[index];
        },
        tabs: const [
          Tab(text: "Now Playing"),
          Tab(text: "Upcoming"),
          Tab(text: "Top Rated"),
          Tab(text: "Popular"),
        ],
      ),
    );
  }
}
