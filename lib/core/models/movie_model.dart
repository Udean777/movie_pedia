class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String? voteAverage;
  final String releaseDate;

  MovieModel(
    this.voteAverage, {
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      (json["vote_average"] ?? 0.0).toDouble().toStringAsFixed(1),
      id: json["id"] ?? 0,
      title: json["title"] ?? "Unknown",
      posterPath: json["poster_path"] != null
          ? "https://image.tmdb.org/t/p/w500${json["poster_path"]}"
          : "",
      backdropPath: json["backdrop_path"] != null
          ? "https://image.tmdb.org/t/p/w500${json["backdrop_path"]}"
          : "",
      releaseDate: json["release_date"] ?? "Unknown",
    );
  }
}
