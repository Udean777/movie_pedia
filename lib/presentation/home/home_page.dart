import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/presentation/home/widget/home_app_bar.dart';
import 'package:movie_pedia/presentation/home/widget/home_tab_bar.dart';
import 'package:movie_pedia/presentation/home/widget/movie_grid.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final movies = ref.watch(moviesProvider(selectedCategory));
    final colorScheme = Theme.of(context).colorScheme;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: HomeAppBar(ref: ref),
        body: Column(
          children: [
            HomeTabBar(ref: ref),
            const SizedBox(height: 10),
            Expanded(
              child: MovieGrid(
                movies: movies,
                colorScheme: colorScheme,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
