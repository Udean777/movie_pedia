import 'package:flutter/material.dart';
import 'package:movie_pedia/presentation/profile/widgets/settings_tile.dart';

/// **Widget `SettingsCard`**
///
/// `SettingsCard` adalah widget yang menampilkan kartu berisi daftar pengaturan.
/// Setiap pengaturan diwakili oleh `SettingsTile`, yang dapat diklik untuk navigasi
/// atau mengaktifkan fitur tertentu.
///
/// **Fitur:**
/// - Menggunakan `Card` untuk tampilan yang rapi.
/// - Memiliki beberapa opsi pengaturan seperti Notifikasi, Privasi, dan Bantuan.
/// - Setiap opsi dipisahkan oleh `Divider` agar lebih mudah dibaca.
/// - Menggunakan skema warna dari `ColorScheme` untuk tampilan yang konsisten.
///
/// **Parameter:**
/// - `colorScheme`: Skema warna dari tema aplikasi yang digunakan untuk konsistensi desain.
class SettingsCard extends StatelessWidget {
  /// Konstruktor `SettingsCard`
  const SettingsCard({
    super.key,
    required this.colorScheme,
  });

  /// Skema warna yang digunakan dalam tema aplikasi.
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      /// **Pengaturan Card**
      /// - Menggunakan warna `surfaceContainerHighest` dari `colorScheme` untuk latar belakang.
      /// - Tidak memiliki efek bayangan (`elevation: 0`) untuk tampilan lebih minimalis.
      elevation: 0,
      color: colorScheme.surfaceContainerHighest,
      child: Column(
        children: [
          /// **Item 1: Notifikasi**
          /// - Menggunakan `SettingsTile` dengan ikon `Icons.notifications_none`.
          /// - `onTap` masih kosong, bisa diisi dengan navigasi atau logika lainnya.
          SettingsTile(
            icon: Icons.notifications_none,
            title: 'Notifications',
            onTap: () {},
            colorScheme: colorScheme,
          ),

          /// **Pembatas antar item**
          /// - `Divider` dengan `height: 1` untuk pemisahan antar opsi.
          const Divider(height: 1),

          /// **Item 2: Privasi**
          /// - Menggunakan ikon `Icons.security` untuk mewakili pengaturan privasi.
          SettingsTile(
            icon: Icons.security,
            title: 'Privacy',
            onTap: () {},
            colorScheme: colorScheme,
          ),

          /// **Pembatas antar item**
          const Divider(height: 1),

          /// **Item 3: Bantuan & Dukungan**
          /// - Menggunakan ikon `Icons.help_outline` untuk bantuan pengguna.
          SettingsTile(
            icon: Icons.help_outline,
            title: 'Help & Support',
            onTap: () {},
            colorScheme: colorScheme,
          ),
        ],
      ),
    );
  }
}
