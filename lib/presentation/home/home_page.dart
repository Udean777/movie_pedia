import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import widget yang digunakan dalam halaman home
import 'package:movie_pedia/presentation/home/widget/home_app_bar.dart';
import 'package:movie_pedia/presentation/home/widget/home_tab_bar.dart';
import 'package:movie_pedia/presentation/home/widget/movie_grid.dart';

/// **`HomePage` adalah halaman utama aplikasi Movie Pedia.**
/// Halaman ini menggunakan `ConsumerWidget` dari Riverpod untuk mengelola state.
///
/// Fitur utama:
/// - `HomeAppBar`: Menampilkan bilah aplikasi dengan judul dan opsi lainnya.
/// - `HomeTabBar`: Menampilkan tab kategori film.
/// - `MovieGrid`: Menampilkan daftar film dalam bentuk grid.
class HomePage extends ConsumerWidget {
  /// Konstruktor `HomePage`
  const HomePage({super.key});

  /// **Membangun tampilan halaman utama**
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length:
          4, // Menentukan jumlah tab (misalnya: Populer, Trending, Top Rated, Upcoming)
      child: Scaffold(
        appBar: HomeAppBar(), // Menggunakan AppBar khusus untuk halaman home
        body: Column(
          children: [
            HomeTabBar(), // Menampilkan tab kategori film
            const SizedBox(height: 10), // Jarak antara tab bar dan grid film
            Expanded(
              child: MovieGrid(), // Menampilkan daftar film dalam bentuk grid
            ),
          ],
        ),
      ),
    );
  }
}
