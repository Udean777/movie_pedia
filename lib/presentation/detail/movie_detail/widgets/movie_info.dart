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
                TabBar(
                  tabs: [
                    Tab(text: 'About'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'Cast'),
                  ],
                  indicatorColor: getTextColor(context),
                  labelColor: getTextColor(context),
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
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
