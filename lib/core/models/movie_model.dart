class MovieModel {
  final int id;
  final String title;
  final String posterPath;
  final String backdropPath;
  final String? voteAverage;
  final String releaseDate;
  final bool adult;
  final List<int> genreIds;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final bool video;
  final int voteCount;

  MovieModel(
    this.voteAverage, {
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.adult,
    required this.genreIds,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.video,
    required this.voteCount,
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
      adult: json["adult"] ?? false,
      genreIds: List<int>.from(json["genre_ids"] ?? []),
      originalLanguage: json["original_language"] ?? "Unknown",
      originalTitle: json["original_title"] ?? "Unknown",
      overview: json["overview"] ?? "No overview available",
      popularity: (json["popularity"] ?? 0.0).toDouble(),
      video: json["video"] ?? false,
      voteCount: json["vote_count"] ?? 0,
    );
  }
}
