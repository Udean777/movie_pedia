import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/about_movie_tab.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/cast_tab.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/widgets/reviews_tab.dart';

class MovieInfo extends StatelessWidget {
  final MovieDetailModel movie;

  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                movie.releaseDate.split('-')[0],
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
              Text(
                '•',
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
              Text(
                '${movie.runtime} Minutes',
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
              Text(
                '•',
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
              Text(
                movie.genres.first.name,
                style: TextStyle(
                  color: getTextColor(context),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TabBar(
                    tabs: const [
                      Tab(text: 'About'),
                      Tab(text: 'Reviews'),
                      Tab(text: 'Cast'),
                    ],
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
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 400,
                  child: TabBarView(
                    children: [
                      AboutMovieTab(
                        movie: movie,
                      ),
                      ReviewsTab(
                        movie: movie,
                      ),
                      CastTab(
                        movie: movie,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
