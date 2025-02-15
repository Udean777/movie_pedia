// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/core/widgets/custom_button.dart';
import 'package:movie_pedia/core/widgets/custom_textfield.dart';
import 'package:movie_pedia/core/widgets/social_sign_button.dart';
import 'package:movie_pedia/presentation/auth/signup_page.dart';
import 'package:movie_pedia/core/widgets/navigation_sign_button.dart';

/// **Halaman Login (`SigninPage`)**
/// Halaman ini memungkinkan pengguna untuk masuk menggunakan email & password, Google, atau Facebook.
class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  /// **Key untuk validasi form login**
  final _formKey = GlobalKey<FormState>();

  /// **Controller untuk input email dan password**
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// **State untuk menampilkan indikator loading saat proses login berlangsung**
  bool _isLoading = false;

  @override
  void dispose() {
    /// **Menghapus controller untuk mencegah kebocoran memori**
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// **Fungsi untuk menangani login menggunakan email & password**
  Future<void> _onLogin() async {
    // **Validasi form sebelum melanjutkan proses login**
    if (!_formKey.currentState!.validate()) return;

    // **Mengaktifkan indikator loading**
    setState(() => _isLoading = true);

    try {
      // **Membaca provider `authServiceProvider` untuk proses autentikasi**
      await ref.read(authServiceProvider).signInWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    } catch (e) {
      // **Menampilkan pesan error jika login gagal**
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      // **Memastikan widget masih dipasang sebelum mengupdate state**
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// **Fungsi untuk login menggunakan Google (belum diimplementasikan)**
  Future<void> _onGoogleLogin() async {
    // Implement Google login logic later
  }

  /// **Fungsi untuk login menggunakan Facebook (belum diimplementasikan)**
  Future<void> _onFacebookLogin() async {
    // Implement Facebook login logic later
  }

  @override
  Widget build(BuildContext context) {
    /// **Menentukan apakah tema saat ini adalah dark mode**
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    /// **Menentukan warna kartu berdasarkan mode tema**
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          /// **Latar belakang gambar login**
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login-image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// **Lapisan transparan dengan efek gradasi untuk meningkatkan keterbacaan teks**
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),

          /// **Menyembunyikan keyboard saat mengetuk di luar input field**
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      /// **Card yang berisi form login**
                      Card(
                        elevation: 8,
                        color: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                /// **Judul halaman login**
                                Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: getTextColor(context),
                                  ),
                                ),
                                const SizedBox(height: 32),

                                /// **Input email**
                                CustomTextField(
                                  controller: _emailController,
                                  icon: Icons.email,
                                  labelText: 'Email',
                                ),
                                const SizedBox(height: 20),

                                /// **Input password**
                                CustomTextField(
                                  controller: _passwordController,
                                  icon: Icons.lock,
                                  labelText: 'Password',
                                  isPassword: true,
                                ),
                                const SizedBox(height: 28),

                                /// **Tombol login**
                                CustomButton(
                                  isLoading: _isLoading,
                                  onPressed: _onLogin,
                                  text: 'Login',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// **Tombol login dengan Google**
                      SocialSignButton(
                        text: 'Login with Google',
                        onPressed: _onGoogleLogin,
                        backgroundColor: Colors.white,
                        icon: Image.asset(
                          'assets/icons8-google-96.png',
                          height: 30,
                          width: 30,
                        ),
                        textColor: Colors.black,
                      ),
                      const SizedBox(height: 12),

                      /// **Tombol login dengan Facebook**
                      SocialSignButton(
                        text: 'Login with Facebook',
                        onPressed: _onFacebookLogin,
                        backgroundColor: Colors.blue,
                        icon: const Icon(
                          Icons.facebook,
                          color: Colors.white,
                          size: 30,
                        ),
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: 24),

                      /// **Navigasi ke halaman registrasi**
                      NavigationSignButton(
                        text: 'Don\'t have an account? ',
                        subText: 'Register',
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
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
