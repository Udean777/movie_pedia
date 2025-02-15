import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/favorite_provider.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';
import 'package:movie_pedia/core/providers/wishlist_provider.dart';
import 'package:movie_pedia/presentation/favorite/favorite_page.dart';
import 'package:movie_pedia/presentation/profile/widgets/info_card.dart';
import 'package:movie_pedia/presentation/profile/widgets/profile_picture.dart';
import 'package:movie_pedia/presentation/profile/widgets/settings_card.dart';
import 'package:movie_pedia/presentation/profile/widgets/stat_card.dart';
import 'package:movie_pedia/presentation/wishlist/wishlist_page.dart';

/// **ProfilePage Widget**
///
/// `ProfilePage` adalah halaman profil pengguna yang menampilkan informasi pengguna, jumlah wishlist,
/// pengaturan akun, serta tombol untuk keluar dari akun.
///
/// Widget ini menggunakan **Riverpod** untuk mengelola state, seperti autentikasi pengguna dan jumlah wishlist.
///
/// **Fitur:**
/// - Menampilkan foto profil pengguna.
/// - Menampilkan informasi akun pengguna.
/// - Menampilkan statistik wishlist pengguna.
/// - Menampilkan daftar pengaturan akun.
/// - Menyediakan tombol logout.
///
/// **Menggunakan:**
/// - `ConsumerWidget` dari Riverpod untuk membaca state global.
/// - `CustomScrollView` dengan `SliverToBoxAdapter` untuk tata letak yang fleksibel.
class ProfilePage extends ConsumerWidget {
  /// Konstruktor `ProfilePage`
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// **Mengambil data pengguna yang sedang login**
    /// - `authStateNotifierProvider` digunakan untuk memantau status autentikasi.
    /// - Jika `user` bernilai `null`, berarti pengguna belum login.
    final user = ref.watch(authStateNotifierProvider).value;

    /// **Mengambil jumlah item di wishlist**
    /// - `wishlistCountProvider` digunakan untuk mendapatkan jumlah wishlist pengguna.
    /// - Menggunakan `.when()` untuk menangani berbagai state (loading, error, data tersedia).
    final wishlistCount = ref.watch(wishlistCountProvider);

    final favoriteCount = ref.watch(favoriteCountProvider);

    /// **Mengambil skema warna dari tema aplikasi**
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      /// **AppBar**
      /// - Menampilkan judul "Profile" di tengah.
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      /// **Body menggunakan `CustomScrollView`**
      /// - Digunakan untuk mendukung scroll yang fleksibel.
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  /// **Menampilkan Foto Profil**
                  /// - Menggunakan `ProfilePicture` widget.
                  ProfilePicture(colorScheme: colorScheme),
                  const SizedBox(height: 24),

                  /// **Menampilkan Informasi Pengguna**
                  /// - Menggunakan `InfoCard` untuk menampilkan detail akun pengguna.
                  InfoCard(
                    colorScheme: colorScheme,
                    user: user,
                  ),
                  const SizedBox(height: 24),

                  /// **Menampilkan Statistik Wishlist**
                  /// - Menggunakan `StatCard` untuk menampilkan jumlah wishlist.
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => WishlistPage(),
                            ),
                          ),
                          child: StatCard(
                            colorScheme: colorScheme,
                            title: 'Wishlist',
                            count: wishlistCount.when(
                              /// Jika data berhasil dimuat, tampilkan jumlah wishlist.
                              data: (count) => count.toString(),

                              /// Jika sedang memuat, tampilkan indikator "..."
                              loading: () => '...',

                              /// Jika terjadi error, tampilkan "0"
                              error: (_, __) => '0',
                            ),
                            icon: Icons.bookmark,
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => FavoritePage(),
                            ),
                          ),
                          child: StatCard(
                            colorScheme: colorScheme,
                            title: 'Favorite',
                            count: favoriteCount.when(
                              /// Jika data berhasil dimuat, tampilkan jumlah favorite.
                              data: (count) => count.toString(),

                              /// Jika sedang memuat, tampilkan indikator "..."
                              loading: () => '...',

                              /// Jika terjadi error, tampilkan "0"
                              error: (_, __) => '0',
                            ),
                            icon: Icons.favorite,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  /// **Menampilkan Kartu Pengaturan**
                  /// - Menggunakan `SettingsCard` untuk daftar pengaturan akun.
                  SettingsCard(colorScheme: colorScheme),
                  const SizedBox(height: 24),

                  /// **Tombol Logout**
                  /// - Menggunakan `FilledButton.tonal` untuk memberikan tampilan tombol yang menarik.
                  /// - Saat ditekan, akan memanggil `signOut()` dari `authServiceProvider`.
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primaryContainer,
                      ),
                      onPressed: () {
                        ref.read(authServiceProvider).signOut();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Sign Out'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
