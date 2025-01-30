class MovieModel {
  final String title;
  final String posterPath;
  final String backdropPath;
  final String? voteAverage;

  MovieModel(
    this.voteAverage, {
    required this.title,
    required this.posterPath,
    required this.backdropPath,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      (json["vote_average"] ?? 0.0).toDouble().toStringAsFixed(1),
      title: json["title"] ?? "Unknown",
      posterPath: json["poster_path"] != null
          ? "https://image.tmdb.org/t/p/w500${json["poster_path"]}"
          : "",
      backdropPath: json["backdrop_path"] != null
          ? "https://image.tmdb.org/t/p/w500${json["backdrop_path"]}"
          : "",
    );
  }
}
