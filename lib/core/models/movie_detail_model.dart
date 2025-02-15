import 'package:movie_pedia/core/models/cast_model.dart';
import 'package:movie_pedia/core/models/genre_model.dart';
import 'package:movie_pedia/core/models/review_model.dart';

/// Model data untuk menyimpan detail informasi sebuah film.
class MovieDetailModel {
  /// ID unik film.
  final int id;

  /// Judul film.
  final String title;

  /// URL gambar poster film.
  final String posterPath;

  /// URL gambar latar belakang (backdrop) film.
  final String backdropPath;

  /// Nilai rata-rata suara (rating) film berdasarkan ulasan pengguna.
  final double voteAverage;

  /// Tanggal rilis film dalam format `YYYY-MM-DD`.
  final String releaseDate;

  /// Durasi film dalam satuan menit.
  final int runtime;

  /// Ringkasan atau deskripsi cerita film.
  final String overview;

  /// Daftar genre yang dimiliki film.
  final List<GenreModel> genres;

  /// Daftar pemeran utama dalam film.
  final List<CastModel> cast;

  /// Daftar ulasan yang diberikan pengguna mengenai film ini.
  final List<ReviewModel> reviews;

  /// Konstruktor untuk membuat objek `MovieDetailModel`.
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

  /// Mengonversi objek `MovieDetailModel` menjadi Map untuk keperluan penyimpanan atau pemrosesan data lebih lanjut.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterPath': posterPath,
      'backdropPath': backdropPath,
      'voteAverage': voteAverage,
      'releaseDate': releaseDate,
      'runtime': runtime,
      'overview': overview,
      'genres': genres.map((genre) => genre.toMap()).toList(),
      'cast': cast.map((c) => c.toMap()).toList(),
      'reviews': reviews.map((r) => r.toMap()).toList(),
    };
  }

  /// Factory constructor untuk mengonversi JSON menjadi objek `MovieDetailModel`.
  ///
  /// - `json['credits']['cast']` digunakan untuk mendapatkan daftar pemeran film.
  /// - `json['reviews']['results']` digunakan untuk mendapatkan daftar ulasan film.
  /// - Jika data tidak tersedia, nilai default diberikan untuk menghindari error.
  factory MovieDetailModel.fromJson(Map<String, dynamic> json) {
    // Mengambil daftar pemeran (cast) dari bagian "credits" dalam JSON.
    List<CastModel> castList = [];
    if (json['credits'] != null && json['credits']['cast'] != null) {
      castList = (json['credits']['cast'] as List)
          .map((castJson) => CastModel.fromJson(castJson))
          .toList();
    }

    // Mengambil daftar ulasan dari bagian "reviews" dalam JSON.
    List<ReviewModel> reviewList = [];
    if (json['reviews'] != null && json['reviews']['results'] != null) {
      reviewList = (json['reviews']['results'] as List)
          .map((reviewJson) => ReviewModel.fromJson(reviewJson))
          .toList();
    }

    return MovieDetailModel(
      /// ID film, default 0 jika tidak ada.
      id: json['id'] ?? 0,

      /// Judul film, default string kosong jika tidak ada.
      title: json['title'] ?? '',

      /// URL poster film, jika tidak ada maka menggunakan placeholder.
      posterPath: json['poster_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['poster_path']}'
          : 'https://via.placeholder.com/500x750', // Placeholder jika tidak tersedia.

      /// URL gambar latar belakang film, jika tidak ada maka menggunakan placeholder.
      backdropPath: json['backdrop_path'] != null
          ? 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}'
          : 'https://via.placeholder.com/500x281', // Placeholder jika tidak tersedia.

      /// Nilai rata-rata rating film, dikonversi ke `double` untuk memastikan format yang benar.
      voteAverage: (json['vote_average'] ?? 0.0).toDouble(),

      /// Tanggal rilis film dalam format `YYYY-MM-DD`, default string kosong jika tidak tersedia.
      releaseDate: json['release_date'] ?? '',

      /// Durasi film dalam menit, default 0 jika tidak tersedia.
      runtime: json['runtime'] ?? 0,

      /// Deskripsi atau sinopsis film, default string kosong jika tidak tersedia.
      overview: json['overview'] ?? '',

      /// Daftar genre film, jika tidak tersedia maka diisi dengan daftar kosong.
      genres: (json['genres'] as List? ?? [])
          .map((genre) => GenreModel.fromJson(genre))
          .toList(),

      /// Daftar pemeran film, jika tidak tersedia maka diisi dengan daftar kosong.
      cast: castList,

      /// Daftar ulasan film, jika tidak tersedia maka diisi dengan daftar kosong.
      reviews: reviewList,
    );
  }
}
