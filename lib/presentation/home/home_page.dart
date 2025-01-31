import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/widgets/logout_dialog.dart';
import 'package:movie_pedia/presentation/home/movie_detail_page.dart';

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
        appBar: _buildAppBar(context, ref),
        body: Column(
          children: [
            _buildTabBar(ref),
            const SizedBox(height: 10),
            Expanded(
              child: _buildMovieGrid(movies, colorScheme),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieGrid(
      AsyncValue<List<MovieModel>> movies, ColorScheme colorScheme) {
    return movies.when(
      data: (movies) => GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.6,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movie.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.network(
                    movie.posterPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.8),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            movie.title,
                            style: TextStyle(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            '⭐ ${movie.voteAverage}',
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Text(
          "Failed to load movies",
          style: TextStyle(color: colorScheme.error),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context, WidgetRef ref) {
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

  TabBar _buildTabBar(WidgetRef ref) {
    return TabBar(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.grey,
      // indicator: ShapeDecoration(
      //   color: Colors.blue,
      //   // shape: RoundedRectangleBorder(
      //   //   borderRadius: BorderRadius.circular(5),
      //   // ),
      // ),
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
