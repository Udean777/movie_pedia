import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    // Initialize the controller here to preserve its state across rebuilds
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
              },
              decoration: InputDecoration(
                hintText: 'Search movies...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: moviesAsync.when(
                data: (data) {
                  if (data.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        children: [
                          Image.asset(
                            'assets/video-player.png',
                            width: 100,
                            height: 100,
                          ),
                          const Text(
                            "No movies found",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final movie = data[index];
                      return ListTile(
                        leading: Image.network(
                          movie.posterPath.isNotEmpty
                              ? movie.posterPath
                              : 'https://via.assets.so/movie.png?id=1&q=95&w=360&h=360&fit=fill',
                          width: 50,
                          height: 75,
                          fit: BoxFit.cover,
                        ),
                        title: Text(movie.title,
                            style: const TextStyle(fontSize: 18)),
                        subtitle: Row(
                          children: [
                            const Icon(Icons.star,
                                color: Colors.amber, size: 18),
                            Text(
                                ' ${movie.voteAverage}  •  ${movie.releaseDate}'),
                          ],
                        ),
                      );
                    },
                  );
                },
                error: (error, stack) => Center(
                  child: Text("Error: $error"),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
