import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';

class HomeTabBar extends StatelessWidget {
  final WidgetRef ref;

  const HomeTabBar({required this.ref, super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: getTextColor(context),
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelColor: Colors.grey,
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: EdgeInsets.symmetric(horizontal: 12),
      onTap: (index) {
        final categories = ["now_playing", "upcoming", "top_rated", "popular"];
        ref.read(selectedCategoryProvider.notifier).state = categories[index];
      },
      tabs: [
        Tab(text: "Now Playing"),
        Tab(text: "Upcoming"),
        Tab(text: "Top Rated"),
        Tab(text: "Popular"),
      ],
    );
  }
}
