import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/genre_model.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/services/tmdb_interceptor.dart';

final dioProvider = Provider<Dio>((ref) => TMDBInterceptor.createDio());

final selectedCategoryProvider = StateProvider<String>((ref) => "now_playing");

final searchQueryProvider = StateProvider<String>((ref) => "");

final searchMoviesProvider =
    FutureProvider.autoDispose<List<MovieModel>>((ref) async {
  final dio = ref.watch(dioProvider);
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) return [];

  final response = await dio.get("/search/movie", queryParameters: {
    "query": query,
  });

  return (response.data["results"] as List)
      .map((json) => MovieModel.fromJson(json))
      .toList();
});

final moviesProvider =
    FutureProvider.family<List<MovieModel>, String>((ref, category) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/movie/$category");
  return (response.data["results"] as List)
      .map((json) => MovieModel.fromJson(json))
      .toList();
});

final movieDetailProvider =
    FutureProvider.family<MovieDetailModel, int>((ref, movieId) async {
  final dio = ref.watch(dioProvider);

  try {
    final response = await dio.get(
      "/movie/$movieId",
      queryParameters: {
        "append_to_response": "credits,reviews",
        "language": "en-US",
      },
    );

    // print("API Response: ${response.data}"); // For debugging
    return MovieDetailModel.fromJson(response.data);
  } catch (e) {
    // print("Error fetching movie details: $e"); // For debugging
    rethrow;
  }
});

final genresProvider = FutureProvider<List<GenreModel>>((ref) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/genre/movie/list");
  return (response.data["genres"] as List)
      .map((json) => GenreModel.fromJson(json))
      .toList();
});
