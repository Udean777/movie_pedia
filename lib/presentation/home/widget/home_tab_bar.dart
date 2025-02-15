import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/tmdb_provider.dart';

/// `HomeTabBar` adalah widget tab bar yang digunakan dalam halaman utama aplikasi.
/// Widget ini menggunakan `ConsumerWidget` untuk mendapatkan akses ke state management dengan Riverpod.
class HomeTabBar extends ConsumerWidget {
  /// Konstruktor `HomeTabBar`
  const HomeTabBar({super.key});

  /// **Membangun tampilan TabBar**
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mengambil skema warna dari tema saat ini
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      // Memberikan margin horizontal untuk TabBar agar tidak menempel ke tepi layar
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        // Menggunakan warna background dari skema warna Material 3
        color: colorScheme.surfaceContainerHighest,
        // Membuat sudut TabBar menjadi melengkung
        borderRadius: BorderRadius.circular(12),
      ),
      child: TabBar(
        // Warna teks untuk tab yang dipilih
        labelColor: colorScheme.onSurface,
        // Warna teks untuk tab yang tidak dipilih
        unselectedLabelColor: colorScheme.onSurfaceVariant,
        // Gaya teks untuk tab yang dipilih
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        // Gaya teks untuk tab yang tidak dipilih
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14,
        ),
        // Indikator tab yang menunjukkan tab aktif
        indicator: BoxDecoration(
          color: colorScheme.primaryContainer, // Warna indikator
          borderRadius:
              BorderRadius.circular(12), // Membuat indikator berbentuk rounded
        ),
        indicatorSize:
            TabBarIndicatorSize.tab, // Indikator akan menyesuaikan ukuran tab
        dividerColor:
            Colors.transparent, // Menghilangkan garis pemisah di TabBar
        splashBorderRadius: BorderRadius.circular(
            12), // Animasi efek splash memiliki sudut membulat
        padding: const EdgeInsets.all(
            4), // Memberikan sedikit padding di dalam TabBar

        // Fungsi yang dipanggil saat pengguna memilih tab
        onTap: (index) {
          // List kategori yang sesuai dengan indeks tab
          final categories = [
            "now_playing", // Film yang sedang tayang
            "upcoming", // Film yang akan datang
            "top_rated", // Film dengan rating tertinggi
            "popular" // Film yang populer
          ];
          // Mengupdate state provider `selectedCategoryProvider` dengan kategori yang dipilih
          ref.read(selectedCategoryProvider.notifier).state = categories[index];
        },

        // Daftar tab yang akan ditampilkan
        tabs: const [
          Tab(text: "Now Playing"), // Tab untuk film yang sedang tayang
          Tab(text: "Upcoming"), // Tab untuk film yang akan datang
          Tab(text: "Top Rated"), // Tab untuk film dengan rating tertinggi
          Tab(text: "Popular"), // Tab untuk film yang populer
        ],
      ),
    );
  }
}
