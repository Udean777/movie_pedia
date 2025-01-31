import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/search/widgets/movies_list.dart';
import 'package:movie_pedia/presentation/search/widgets/search_textfield.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final moviesAsync = ref.watch(searchMoviesProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search Movies',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SearchTextField(controller: searchController),
              const SizedBox(height: 16),
              Expanded(
                child: moviesAsync.when(
                  data: (movies) => movies.isEmpty
                      ? const NotFound(
                          image: 'assets/video-player.png',
                          title: 'No movies found',
                        )
                      : MoviesList(movies: movies),
                  error: (error, stack) => Center(
                    child: Text("Error: $error"),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
