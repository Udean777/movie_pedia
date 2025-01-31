import 'package:flutter/material.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/presentation/home/widget/about_movie_tab.dart';
import 'package:movie_pedia/presentation/home/widget/cast_tab.dart';
import 'package:movie_pedia/presentation/home/widget/reviews_tab.dart';

class MovieInfo extends StatelessWidget {
  final MovieDetailModel movie;

  const MovieInfo({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                movie.releaseDate.split('-')[0],
                style: const TextStyle(color: Colors.black),
              ),
              const Text('•', style: TextStyle(color: Colors.black)),
              Text(
                '${movie.runtime} Minutes',
                style: const TextStyle(color: Colors.black),
              ),
              const Text('•', style: TextStyle(color: Colors.black)),
              Text(
                movie.genres.first.name,
                style: const TextStyle(color: Colors.black),
              ),
            ],
          ),
          const SizedBox(height: 24),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: 'About'),
                    Tab(text: 'Reviews'),
                    Tab(text: 'Cast'),
                  ],
                  indicatorColor: Colors.black,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 400,
                  child: TabBarView(
                    children: [
                      AboutMovieTab(movie: movie),
                      ReviewsTab(movie: movie),
                      CastTab(movie: movie),
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
