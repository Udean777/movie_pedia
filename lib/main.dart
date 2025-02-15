import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_pedia/core/wrapper/auth_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// **Fungsi utama (main) untuk menjalankan aplikasi**
void main() async {
  /// **Pastikan widget binding telah diinisialisasi sebelum melakukan inisialisasi asinkron**
  WidgetsFlutterBinding.ensureInitialized();

  /// **Memuat variabel lingkungan dari file `.env`**
  /// Ini digunakan untuk menyimpan konfigurasi sensitif seperti API keys.
  await dotenv.load(fileName: ".env");

  /// **Inisialisasi Firebase dengan opsi yang sesuai berdasarkan platform saat ini**
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// **Menjalankan aplikasi dengan menggunakan `ProviderScope`**
  /// `ProviderScope` digunakan untuk mengaktifkan state management dengan Riverpod.
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

/// **Kelas utama aplikasi Flutter**
/// `MyApp` adalah kelas utama yang mengatur tema, rute, dan halaman awal aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      /// **Judul aplikasi**
      title: 'Movie Pedia',

      /// **Mode tema mengikuti pengaturan sistem**
      themeMode: ThemeMode.system,

      /// **Tema gelap menggunakan `FlexColorScheme` dengan skema warna `blueWhale`**
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.blueWhale,
      ),

      /// **Tema terang menggunakan `FlexColorScheme` dengan skema warna `blueWhale`**
      theme: FlexThemeData.light(
        scheme: FlexScheme.blueWhale,
      ),

      /// **Menghilangkan banner "Debug" di aplikasi saat mode debug**
      debugShowCheckedModeBanner: false,

      /// **Menentukan halaman awal aplikasi**
      /// `AuthWrapper` akan menangani logika autentikasi pengguna.
      home: AuthWrapper(),
    );
  }
}
