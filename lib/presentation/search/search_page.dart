import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/search/widgets/movies_list.dart';
import 'package:movie_pedia/presentation/search/widgets/search_textfield.dart';

/// `SearchPage` adalah halaman pencarian film.
/// Menggunakan `ConsumerStatefulWidget` agar dapat berinteraksi dengan state dari Riverpod.
class SearchPage extends ConsumerStatefulWidget {
  /// Konstruktor `SearchPage`
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

/// State untuk `SearchPage` yang memungkinkan penggunaan `TextEditingController`
/// untuk menangani input pengguna.
class SearchPageState extends ConsumerState<SearchPage> {
  /// Controller untuk mengontrol teks yang diketik pengguna dalam `SearchTextField`
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    // Inisialisasi `TextEditingController`
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // Membersihkan `TextEditingController` saat widget dihancurkan
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan provider untuk mendapatkan daftar film berdasarkan query pencarian
    final moviesAsync = ref.watch(searchMoviesProvider);

    return GestureDetector(
      // Menutup keyboard ketika pengguna mengetuk di luar `TextField`
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Search Movies',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true, // Membuat judul di tengah AppBar
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Input pencarian film
              SearchTextField(controller: searchController),
              const SizedBox(height: 16), // Spasi antara input dan daftar film
              Expanded(
                child: moviesAsync.when(
                  // Jika data berhasil dimuat, tampilkan daftar film
                  data: (movies) => movies.isEmpty
                      ? const NotFound(
                          image: 'assets/video-player.png',
                          title: 'No movies found',
                        )
                      : MoviesList(movies: movies),
                  // Jika terjadi kesalahan, tampilkan pesan error
                  error: (error, stack) => Center(
                    child: Text("Error: $error"),
                  ),
                  // Jika masih dalam proses loading, tampilkan indikator loading
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
