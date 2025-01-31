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

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _onGoogleLogin() async {
    // Implement Google login logic later
  }

  Future<void> _onFacebookLogin() async {
    // Implement Facebook login logic later
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password does not match!')),
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
          Container(
            decoration: BoxDecoration(
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
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 40),
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
                                  'Create Your Account',
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
                                  labelText: 'Confirm Password',
                                  isPassword: true,
                                ),
                                SizedBox(height: 28),
                                CustomButton(
                                  isLoading: _isLoading,
                                  onPressed: _submit,
                                  text: 'Register',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      SocialSignButton(
                        text: 'Sign up with Google',
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
                        text: 'Sign up with Facebook',
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
                      NavigationSignButton(
                        text: 'Already have an account? ',
                        subText: 'Login',
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
