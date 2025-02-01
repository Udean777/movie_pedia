// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/core/providers/firebase_auth_provider.dart';
import 'package:movie_pedia/core/utils/get_text_color.dart';
import 'package:movie_pedia/core/widgets/custom_button.dart';
import 'package:movie_pedia/core/widgets/custom_textfield.dart';
import 'package:movie_pedia/core/widgets/social_sign_button.dart';
import 'package:movie_pedia/presentation/auth/signup_page.dart';
import 'package:movie_pedia/core/widgets/navigation_sign_button.dart';

class SigninPage extends ConsumerStatefulWidget {
  const SigninPage({super.key});

  @override
  ConsumerState<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends ConsumerState<SigninPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await ref.read(authServiceProvider).signInWithEmailAndPassword(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
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

  Future<void> _onGoogleLogin() async {
    // Implement Google login logic later
  }

  Future<void> _onFacebookLogin() async {
    // Implement Facebook login logic later
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/login-image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
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
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
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
                                Text(
                                  'Welcome Back!',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    color: getTextColor(context),
                                  ),
                                ),
                                const SizedBox(height: 32),
                                CustomTextField(
                                  controller: _emailController,
                                  icon: Icons.email,
                                  labelText: 'Email',
                                ),
                                const SizedBox(height: 20),
                                CustomTextField(
                                  controller: _passwordController,
                                  icon: Icons.lock,
                                  labelText: 'Password',
                                  isPassword: true,
                                ),
                                const SizedBox(height: 28),
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
