import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/models/movie_model.dart';
import 'package:movie_pedia/core/services/tmdb_interceptor.dart';

final dioProvider = Provider<Dio>((ref) => TMDBInterceptor.createDio());

final selectedCategoryProvider = StateProvider<String>((ref) => "now_playing");

final moviesProvider =
    FutureProvider.family<List<MovieModel>, String>((ref, category) async {
  final dio = ref.watch(dioProvider);
  final response = await dio.get("/movie/$category");
  return (response.data["results"] as List)
      .map((json) => MovieModel.fromJson(json))
      .toList();
});
