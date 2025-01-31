import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/home/movie_detail_page.dart';

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
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
                      return NotFound(
                        image: 'assets/video-player.png',
                        title: 'No movies found',
                      );
                    }

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final movie = data[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailPage(movieId: movie.id),
                              ),
                            );
                          },
                          child: ListTile(
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
      ),
    );
  }
}
