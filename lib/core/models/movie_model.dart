/// Model data untuk film, digunakan untuk menyimpan informasi dasar tentang film.
class MovieModel {
  /// ID unik film.
  final int id;

  /// Judul film.
  final String title;

  /// URL gambar poster film.
  final String posterPath;

  /// URL gambar latar belakang film.
  final String backdropPath;

  /// Rata-rata suara (rating) film dalam bentuk string dengan satu angka di belakang koma.
  /// Nilai ini bisa `null` jika tidak tersedia.
  final String? voteAverage;

  /// Tanggal rilis film dalam format `YYYY-MM-DD`.
  final String releaseDate;

  /// Status apakah film ini memiliki konten dewasa (18+) atau tidak.
  final bool adult;

  /// Daftar ID genre yang terkait dengan film ini.
  final List<int> genreIds;

  /// Bahasa asli film, misalnya `"en"`, `"ja"`, `"fr"`, dll.
  final String originalLanguage;

  /// Judul asli film dalam bahasa aslinya.
  final String originalTitle;

  /// Ringkasan atau deskripsi film.
  final String overview;

  /// Tingkat kepopuleran film berdasarkan metrik tertentu.
  final double popularity;

  /// Status apakah film ini adalah video atau tidak.
  final bool video;

  /// Jumlah total suara (vote count) yang diberikan untuk film ini.
  final int voteCount;

  /// Konstruktor untuk `MovieModel`.
  ///
  /// - `voteAverage` diletakkan sebagai positional parameter pertama karena mungkin bernilai `null`.
  /// - Parameter lainnya bersifat `required` untuk memastikan semua data utama tersedia.
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

  /// Factory constructor untuk membuat objek `MovieModel` dari JSON.
  ///
  /// - Menangani kemungkinan nilai `null` dalam JSON dengan nilai default yang sesuai.
  /// - Mengubah `vote_average` menjadi string dengan format satu angka di belakang koma.
  /// - Mengonversi `poster_path` dan `backdrop_path` menjadi URL TMDB, atau memberikan string kosong jika tidak tersedia.
  /// - Mengubah `genre_ids` menjadi daftar `List<int>` untuk mewakili genre film.
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      // Mengonversi vote_average ke string dengan 1 angka desimal
      (json["vote_average"] ?? 0.0).toDouble().toStringAsFixed(1),
      id: json["id"] ?? 0,
      title: json["title"] ?? "Unknown",
      posterPath: json["poster_path"] != null
          ? "https://image.tmdb.org/t/p/w500${json["poster_path"]}"
          : "", // Jika poster tidak tersedia, berikan string kosong
      backdropPath: json["backdrop_path"] != null
          ? "https://image.tmdb.org/t/p/w500${json["backdrop_path"]}"
          : "", // Jika backdrop tidak tersedia, berikan string kosong
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
