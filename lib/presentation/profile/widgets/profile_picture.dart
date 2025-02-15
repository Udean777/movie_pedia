import 'package:flutter/material.dart';

/// **Widget `ProfilePicture`**
///
/// `ProfilePicture` adalah widget yang menampilkan gambar profil pengguna dalam bentuk
/// lingkaran dengan ikon default jika tidak ada gambar yang dimuat.
///
/// **Fitur:**
/// - Berbentuk lingkaran.
/// - Memiliki warna latar yang dapat disesuaikan dari `colorScheme.secondaryContainer`.
/// - Memiliki border dengan warna `colorScheme.primary`.
/// - Menampilkan ikon default `Icons.person` jika tidak ada gambar profil yang tersedia.
///
/// **Parameter:**
/// - `colorScheme`: Skema warna dari tema aplikasi untuk konsistensi desain.
class ProfilePicture extends StatelessWidget {
  /// Konstruktor `ProfilePicture`
  const ProfilePicture({
    super.key,
    required this.colorScheme,
  });

  /// Skema warna yang digunakan dalam tema aplikasi.
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      /// **Ukuran Profil**
      /// - Lebar dan tinggi ditetapkan sebesar 120x120 untuk menjaga bentuk proporsional.
      width: 120,
      height: 120,

      /// **Dekorasi Profil**
      /// - Menggunakan `BoxDecoration` untuk membentuk lingkaran dan menambahkan border.
      decoration: BoxDecoration(
        shape: BoxShape.circle, // Membuat bentuk lingkaran.
        color: colorScheme.secondaryContainer, // Warna latar belakang profil.

        /// **Border Profil**
        /// - Warna border menggunakan `colorScheme.primary`.
        /// - Lebar border ditetapkan sebesar 3.
        border: Border.all(
          color: colorScheme.primary,
          width: 3,
        ),
      ),

      /// **Ikon Default Profil**
      /// - Jika pengguna tidak memiliki foto profil, ikon `Icons.person` akan ditampilkan.
      /// - Ikon memiliki ukuran 60 dan warna `colorScheme.onSecondaryContainer`.
      child: Icon(
        Icons.person,
        size: 60,
        color: colorScheme.onSecondaryContainer,
      ),
    );
  }
}
