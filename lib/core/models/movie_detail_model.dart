import 'package:movie_pedia/core/models/cast_model.dart';
import 'package:movie_pedia/core/models/genre_model.dart';
import 'package:movie_pedia/core/models/review_model.dart';

class MovieDetailModel {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  final String overview;
  final List<GenreModel> genres;
  final List<CastModel> cast;
  final List<ReviewModel> reviews;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.overview,
    required this.genres,
    required this.cast,
    required this.reviews,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    List<CastModel> castList = [];
    if (json['credits'] != null && json['credits']['cast'] != null) {
      castList = (json['credits']['cast'] as List)
          .map((castJson) => CastModel.fromJson(castJson))
          .toList();
    }

    List<ReviewModel> reviewList = [];
    if (json['reviews'] != null && json['reviews']['results'] != null) {
      reviewList = (json['reviews']['results'] as List)
          .map((reviewJson) => ReviewModel.fromJson(reviewJson))
          .toList();
    }

    return MovieDetailModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      posterPath: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://via.placeholder.com/500x750',
      backdropPath: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : 'https://via.placeholder.com/500x281',
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      overview: json['overview'] ?? '',
      genres: (json['genres'] as List? ?? [])
          .map((genre) => GenreModel.fromJson(genre))
          .toList(),
      cast: castList,
      reviews: reviewList,
    );
  }
}
