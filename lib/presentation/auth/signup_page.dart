// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/core/widgets/custom_button.dart';
import 'package:movie_pedia/core/widgets/custom_textfield.dart';
import 'package:movie_pedia/core/widgets/navigation_sign_button.dart';
import 'package:movie_pedia/core/widgets/social_sign_button.dart';
import 'package:movie_pedia/presentation/auth/signin_page.dart';

/// Widget yang menampilkan halaman pendaftaran (sign-up) dari aplikasi.
///
/// Halaman ini memungkinkan pengguna untuk membuat akun baru menggunakan email/password
/// atau melalui penyedia autentikasi sosial (Google dan Facebook).
/// Halaman ini mencakup validasi formulir dan penanganan kesalahan untuk proses pendaftaran.
class SignupPage extends ConsumerStatefulWidget {
  /// Membuat halaman pendaftaran.
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

/// State untuk widget [SignupPage].
///
/// Mengelola state formulir, controller input pengguna, dan proses autentikasi
/// untuk fungsionalitas pendaftaran.
class _SignupPageState extends ConsumerState<SignupPage> {
  /// Key untuk widget form untuk mengelola state dan validasi formulir.
  final _formKey = GlobalKey<FormState>();

  /// Controller untuk field input email.
  final _emailController = TextEditingController();

  /// Controller untuk field input password.
  final _passwordController = TextEditingController();

  /// Controller untuk field input konfirmasi password.
  final _confirmPasswordController = TextEditingController();

  /// Flag untuk melacak apakah operasi autentikasi sedang berlangsung.
  bool _isLoading = false;

  /// Memulai proses masuk dengan Google.
  ///
  /// Metode ini akan diimplementasikan untuk menangani integrasi
  /// autentikasi Google di masa mendatang.
  Future<void> _onGoogleLogin() async {
    // Implementasi logika login Google nanti
  }

  /// Memulai proses masuk dengan Facebook.
  ///
  /// Metode ini akan diimplementasikan untuk menangani integrasi
  /// autentikasi Facebook di masa mendatang.
  Future<void> _onFacebookLogin() async {
    // Implementasi logika login Facebook nanti
  }

  /// Menangani pengiriman formulir untuk pendaftaran email/password.
  ///
  /// Melakukan langkah-langkah berikut:
  /// 1. Memvalidasi input formulir
  /// 2. Memeriksa apakah password cocok
  /// 3. Mencoba membuat akun pengguna baru
  /// 4. Menangani kesalahan yang terjadi selama pendaftaran
  ///
  /// Menampilkan pesan kesalahan yang sesuai kepada pengguna jika ada langkah yang gagal.
  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak cocok!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(authServiceProvider).signUpWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          // Container gambar latar belakang
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login-image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Container lapisan gradien
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.3),
                  Colors.black.withValues(alpha: 0.7),
                ],
              ),
            ),
          ),
          // Konten utama
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      // Kartu formulir pendaftaran
                      Card(
                        color: cardColor,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Text(
                                  'Buat Akun Anda',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: getTextColor(context),
                                  ),
                                ),
                                SizedBox(height: 32),
                                CustomTextField(
                                  controller: _emailController,
                                  icon: Icons.email,
                                  labelText: 'Email',
                                ),
                                SizedBox(height: 20),
                                CustomTextField(
                                  controller: _passwordController,
                                  icon: Icons.lock,
                                  labelText: 'Password',
                                  isPassword: true,
                                ),
                                SizedBox(height: 20),
                                CustomTextField(
                                  controller: _confirmPasswordController,
                                  icon: Icons.lock_outline,
                                  labelText: 'Konfirmasi Password',
                                  isPassword: true,
                                ),
                                SizedBox(height: 28),
                                CustomButton(
                                  isLoading: _isLoading,
                                  onPressed: _submit,
                                  text: 'Daftar',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      // Tombol masuk dengan media sosial
                      SocialSignButton(
                        text: 'Daftar dengan Google',
                        onPressed: _onGoogleLogin,
                        backgroundColor: Colors.white,
                        icon: Image.asset(
                          'assets/icons8-google-96.png',
                          height: 30,
                          width: 30,
                        ),
                        textColor: Colors.black,
                      ),
                      SizedBox(height: 12),
                      SocialSignButton(
                        text: 'Daftar dengan Facebook',
                        onPressed: _onFacebookLogin,
                        backgroundColor: Colors.blue,
                        icon: Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size: 30,
                        ),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 24),
                      // Navigasi ke halaman masuk
                      NavigationSignButton(
                        text: 'Sudah punya akun? ',
                        subText: 'Masuk',
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SigninPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
