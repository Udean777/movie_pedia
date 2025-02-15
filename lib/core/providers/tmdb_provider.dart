import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/genre_model.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/services/tmdb_interceptor.dart';

/// Provider untuk mengelola instance `Dio` dengan interceptor TMDB.
final dioProvider = Provider<Dio>((ref) => TMDBInterceptor.createDio());

/// State provider untuk menyimpan kategori film yang dipilih.
/// Defaultnya adalah `"now_playing"`.
final selectedCategoryProvider = StateProvider<String>((ref) => "now_playing");

/// State provider untuk menyimpan query pencarian film.
/// Nilai awalnya adalah string kosong.
final searchQueryProvider = StateProvider<String>((ref) => "");

/// FutureProvider untuk mencari film berdasarkan query pengguna.
/// Menggunakan autoDispose agar tidak membebani memori saat tidak digunakan.
final searchMoviesProvider =
    FutureProvider.autoDispose<List<MovieModel>>((ref) async {
  final dio = ref.watch(dioProvider);
  final query = ref.watch(searchQueryProvider);

  // Jika query kosong, kembalikan list kosong.
  if (query.isEmpty) return [];

  // Melakukan request pencarian film ke API TMDB.
  final response = await dio.get("/search/movie", queryParameters: {
    "query": query,
  });

  // Mengonversi hasil JSON ke dalam list `MovieModel`.
  return (response.data["results"] as List)
      .map((json) => MovieModel.fromJson(json))
      .toList();
});

/// FutureProvider untuk mengambil daftar film berdasarkan genre yang sama
/// Menggunakan movie ID untuk mendapatkan genre dari film tersebut,
/// kemudian mencari film lain dengan genre yang sama
final similarMoviesProvider =
    FutureProvider.family<List<MovieModel>, int>((ref, movieId) async {
  final dio = ref.watch(dioProvider);

  try {
    // 1. Pertama, dapatkan detail film untuk mendapatkan genre IDs
    final movieDetail = await dio.get(
      "/movie/$movieId",
      queryParameters: {
        "language": "en-US",
      },
    );

    // Ekstrak genre IDs dari detail film
    final List<int> genreIds = (movieDetail.data["genres"] as List)
        .map((genre) => genre["id"] as int)
        .toList();

    if (genreIds.isEmpty) {
      return [];
    }

    // 2. Kemudian, cari film berdasarkan genre pertama
    // Menggunakan genre pertama untuk mendapatkan hasil yang lebih fokus
    final response = await dio.get(
      "/discover/movie",
      queryParameters: {
        "language": "en-US",
        "with_genres": genreIds.first.toString(),
        "page": 1,
        "sort_by": "popularity.desc", // Urutkan berdasarkan popularitas
        "exclude_ids": movieId.toString(), // Exclude film yang sedang dilihat
      },
    );

    // 3. Konversi hasil JSON ke dalam list MovieModel
    final List<MovieModel> movies = (response.data["results"] as List)
        .map((json) => MovieModel.fromJson(json))
        .where((movie) =>
            movie.id !=
            movieId) // Double check untuk menghindari film yang sama
        .take(10) // Batasi hanya 10 film
        .toList();

    return movies;
  } catch (e) {
    rethrow;
  }
});

/// FutureProvider yang mengambil daftar film berdasarkan kategori yang dipilih.
/// Menggunakan `.family` untuk menerima parameter kategori.
/// Jika kategori adalah "now_playing", hanya menampilkan 5 film.
/// Jika kategori adalah "popular", hanya menampilkan 20 film.
final moviesProvider =
    FutureProvider.family<List<MovieModel>, String>((ref, category) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/movie/$category");

  // Konversi hasil JSON ke dalam list `MovieModel`.
  List<MovieModel> movies = (response.data["results"] as List)
      .map((json) => MovieModel.fromJson(json))
      .toList();

  // Batasi jumlah film yang ditampilkan berdasarkan kategori.
  if (category == "now_playing") {
    return movies.take(5).toList();
  } else if (category == "popular") {
    return movies.take(20).toList();
  }

  return movies;
});

/// FutureProvider untuk mengambil detail film berdasarkan `movieId`.
final movieDetailProvider =
    FutureProvider.family<MovieDetailModel, int>((ref, movieId) async {
  final dio = ref.watch(dioProvider);

  try {
    // Melakukan request untuk mendapatkan detail film dari API TMDB.
    final response = await dio.get(
      "/movie/$movieId",
      queryParameters: {
        "append_to_response": "credits,reviews", // Menambahkan kredit & ulasan.
        "language": "en-US",
      },
    );

    // Mengonversi hasil JSON ke dalam objek `MovieDetailModel`.
    return MovieDetailModel.fromJson(response.data);
  } catch (e) {
    // Menampilkan error jika terjadi kesalahan saat fetch data.
    rethrow;
  }
});

/// FutureProvider untuk mengambil daftar genre film dari API TMDB.
final genresProvider = FutureProvider<List<GenreModel>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/genre/movie/list");

  // Mengonversi hasil JSON ke dalam list `GenreModel`.
  return (response.data["genres"] as List)
      .map((json) => GenreModel.fromJson(json))
      .toList();
});
