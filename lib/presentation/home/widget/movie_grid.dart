import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:movie_pedia/core/providers/tmdb_provider.dart';
import 'package:movie_pedia/core/widgets/not_found.dart';
import 'package:movie_pedia/presentation/detail/movie_detail/movie_detail_page.dart';

/// `MovieGrid` adalah widget yang menampilkan daftar film dalam bentuk grid.
/// Widget ini menggunakan `ConsumerWidget` untuk membaca state dari Riverpod.
class MovieGrid extends ConsumerWidget {
  /// Konstruktor `MovieGrid`
  const MovieGrid({super.key});

  /// **Membangun tampilan grid film**
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mengambil kategori film yang dipilih dari Riverpod state
    final selectedCategory = ref.watch(selectedCategoryProvider);

    // Mengambil daftar film berdasarkan kategori yang dipilih
    final movies = ref.watch(moviesProvider(selectedCategory));

    // Mengambil skema warna dari tema saat ini
    final colorScheme = Theme.of(context).colorScheme;

    return movies.when(
      // Jika data film berhasil dimuat
      data: (movies) => GridView.builder(
        padding: const EdgeInsets.all(12), // Memberikan padding di sekitar grid
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Menampilkan 2 kolom dalam grid
          crossAxisSpacing: 12, // Jarak horizontal antar item dalam grid
          mainAxisSpacing: 12, // Jarak vertikal antar item dalam grid
          childAspectRatio:
              0.6, // Rasio ukuran item dalam grid (tinggi dibandingkan lebar)
        ),
        itemCount: movies.length, // Jumlah item yang ditampilkan dalam grid
        itemBuilder: (context, index) {
          final movie = movies[index];

          // Jika daftar film kosong, tampilkan widget "Not Found"
          if (movies.isEmpty) {
            return NotFound(
              image:
                  'assets/video-player.png', // Gambar untuk menunjukkan tidak ada data
              title: 'No Movies', // Teks yang ditampilkan
            );
          }

          // Widget untuk menampilkan poster film
          return GestureDetector(
            // Navigasi ke halaman detail film saat pengguna mengetuk poster
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailPage(movieId: movie.id),
                ),
              );
            },
            child: ClipRRect(
              borderRadius:
                  BorderRadius.circular(12), // Membuat sudut poster melengkung
              child: Stack(
                children: [
                  // Menampilkan gambar poster film
                  Image.network(
                    movie.posterPath, // URL gambar poster
                    fit: BoxFit
                        .cover, // Menyesuaikan gambar agar pas dalam frame
                    width: double.infinity, // Lebar penuh
                    height: double.infinity, // Tinggi penuh
                  ),
                  // Overlay untuk menampilkan judul dan rating film di bagian bawah poster
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(
                          6), // Padding untuk teks di dalam container
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(
                                0.8), // Warna hitam dengan transparansi 80%
                            Colors
                                .transparent // Warna transparan untuk efek gradasi
                          ],
                          begin: Alignment
                              .bottomCenter, // Gradasi dimulai dari bawah
                          end: Alignment.topCenter, // Gradasi berakhir di atas
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Menampilkan judul film
                          Text(
                            movie.title,
                            style: TextStyle(
                              color: colorScheme
                                  .onPrimary, // Warna teks sesuai tema
                              fontWeight:
                                  FontWeight.bold, // Teks bold untuk judul
                            ),
                            overflow: TextOverflow
                                .ellipsis, // Jika teks terlalu panjang, akan dipotong dengan "..."
                          ),
                          // Menampilkan rating film
                          Text(
                            '⭐ ${movie.voteAverage}',
                            style: const TextStyle(
                              color: Colors
                                  .amber, // Warna kuning untuk rating bintang
                              fontWeight:
                                  FontWeight.bold, // Teks bold untuk rating
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Jika masih loading, tampilkan indikator loading
      loading: () => const Center(child: CircularProgressIndicator()),
      // Jika terjadi error, tampilkan pesan error
      error: (error, _) => Center(
        child: Text(
          "Failed to load movies", // Pesan error
          style: TextStyle(
              color: colorScheme.error), // Warna teks error sesuai tema
        ),
      ),
    );
  }
}
