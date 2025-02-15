import 'package:flutter/material.dart';
import 'package:movie_pedia/presentation/home/home_page.dart';
import 'package:movie_pedia/presentation/profile/profile_page.dart';
import 'package:movie_pedia/presentation/search/search_page.dart';
import 'package:movie_pedia/presentation/wishlist/wishlist_page.dart';

/// `MainPage` adalah halaman utama yang mengelola navigasi antar halaman
/// menggunakan `BottomNavigationBar`. Ini memungkinkan pengguna untuk berpindah
/// antara halaman utama, pencarian, wishlist, dan profil.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// `int _selectedIndex` menyimpan indeks halaman yang sedang aktif/dipilih.
  int _selectedIndex = 0;

  /// `items` adalah daftar halaman yang akan ditampilkan berdasarkan indeks yang dipilih.
  static final List<Widget> items = <Widget>[
    HomePage(),
    SearchPage(),
    WishlistPage(),
    ProfilePage(),
  ];

  /// Fungsi `_onItemTapped(int index)` digunakan untuk memperbarui indeks halaman aktif
  /// ketika pengguna memilih salah satu tab di `BottomNavigationBar`.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Mengambil `colorScheme` dari tema aplikasi agar warna selaras dengan tema global.
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      /// `body` akan menampilkan halaman sesuai dengan `_selectedIndex`.
      body: items.elementAt(_selectedIndex),

      /// `BottomNavigationBar` digunakan untuk navigasi antar halaman.
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
                Icons.home_outlined), // Ikon untuk tab "Home" saat tidak aktif.
            activeIcon: Icon(Icons.home), // Ikon untuk tab "Home" saat aktif.
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .search_outlined), // Ikon untuk tab "Search" saat tidak aktif.
            activeIcon:
                Icon(Icons.search), // Ikon untuk tab "Search" saat aktif.
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .favorite_border), // Ikon untuk tab "Wishlist" saat tidak aktif.
            activeIcon:
                Icon(Icons.favorite), // Ikon untuk tab "Wishlist" saat aktif.
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons
                .person_outline), // Ikon untuk tab "Profile" saat tidak aktif.
            activeIcon:
                Icon(Icons.person), // Ikon untuk tab "Profile" saat aktif.
            label: 'Profile',
          ),
        ],

        /// Menentukan indeks yang sedang dipilih agar tab yang sesuai disorot.
        currentIndex: _selectedIndex,

        /// Warna item yang dipilih mengikuti warna utama dari `colorScheme`.
        selectedItemColor: colorScheme.primary,

        /// Warna item yang tidak dipilih lebih redup untuk memberikan perbedaan visual.
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),

        /// Menyembunyikan label untuk item yang tidak dipilih.
        showUnselectedLabels: false,

        /// `BottomNavigationBarType.fixed` digunakan agar item tidak bergeser saat dipilih.
        type: BottomNavigationBarType.fixed,

        /// Fungsi yang dipanggil saat salah satu tab ditekan.
        onTap: _onItemTapped,

        /// Menambahkan efek elevasi untuk memberikan tampilan yang lebih menonjol.
        elevation: 10,

        /// Mengatur warna latar belakang `BottomNavigationBar` agar sesuai dengan tema.
        backgroundColor: colorScheme.surface,
      ),
    );
  }
}
