import 'package:movie_pedia/core/models/genre_model.dart';

class MovieDetailModel {
  final String title;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final List<GenreModel> genres;

  MovieDetailModel({
    required this.title,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.overview,
    required this.genres,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    return MovieDetailModel(
      title: json["title"],
      backdropPath: json["backdrop_path"] ?? "",
      voteAverage: (json["vote_average"] as num).toDouble(),
      releaseDate: json["release_date"] ?? "Unknown",
      overview: json["overview"] ?? "No description available.",
      genres: (json["genres"] as List)
          .map((genreJson) => GenreModel.fromJson(genreJson))
          .toList(),
    );
  }
}
