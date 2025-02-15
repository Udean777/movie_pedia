import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'dart:developer' as developer; // Untuk debugging (dapat diaktifkan jika diperlukan).

/// Kelas `TMDBInterceptor` digunakan untuk mengatur konfigurasi HTTP request ke API TMDB (The Movie Database).
/// Kelas ini menggunakan package `Dio` untuk melakukan request dengan interceptor guna menangani request dan response.
class TMDBInterceptor {
  /// Base URL dari API TMDB.
  static const String baseUrl = "https://api.themoviedb.org/3";

  /// API Key yang diambil dari file `.env` menggunakan `flutter_dotenv`.
  /// API key ini digunakan untuk mengautentikasi setiap request ke TMDB.
  static String apiKey = dotenv.env['TMDB_API_KEY']!;

  /// Method `createDio` digunakan untuk mengembalikan instance `Dio`
  /// yang telah dikonfigurasi dengan `BaseOptions` dan interceptor.
  ///
  /// - Menetapkan `baseUrl` sebagai base dari setiap request.
  /// - Menetapkan `connectTimeout` untuk membatasi waktu koneksi sebelum request gagal.
  /// - Menambahkan `InterceptorsWrapper` untuk menangani request, response, dan error.
  ///
  /// Mengembalikan instance `Dio` yang telah dikonfigurasi.
  static Dio createDio() {
    // developer.log('TMDB_API_KEY: $apiKey', name: 'TMDBInterceptor'); // Debugging API Key.

    /// Membuat instance `Dio` dengan opsi dasar seperti `baseUrl` dan `connectTimeout`.
    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(
            seconds: 10), // Timeout jika koneksi lebih dari 10 detik.
      ),
    );

    /// Menambahkan interceptor untuk menangani request, response, dan error.
    dio.interceptors.add(InterceptorsWrapper(
      /// Interceptor untuk menangani setiap request yang dikirim.
      /// Menambahkan `api_key` ke setiap request untuk autentikasi ke TMDB.
      onRequest: (options, handler) {
        // developer.log(
        //     'Request[${options.method}] => PATH: ${options.path}, QUERY: ${options.queryParameters}',
        //     name: 'TMDBInterceptor'); // Debugging request.

        options.queryParameters['api_key'] =
            apiKey; // Menambahkan API key ke setiap request.
        handler.next(options); // Melanjutkan request.
      },

      /// Interceptor untuk menangani response yang diterima dari server.
      /// Bisa digunakan untuk logging atau memodifikasi response sebelum diberikan ke aplikasi.
      onResponse: (response, handler) {
        // developer.log(
        //     'Response[${response.statusCode}] => DATA: ${response.data}',
        //     name: 'TMDBInterceptor'); // Debugging response.

        handler.next(response); // Melanjutkan response.
      },

      /// Interceptor untuk menangani error yang terjadi saat request.
      /// Bisa digunakan untuk menangani error secara global dan memberikan pesan yang lebih user-friendly.
      onError: (DioException error, handler) {
        // developer.log(
        //     'Error[${error.response?.statusCode}] => MESSAGE: ${error.message}',
        //     name: 'TMDBInterceptor'); // Debugging error.

        handler.next(error); // Melanjutkan error ke pemanggil request.
      },
    ));

    return dio;
  }
}
