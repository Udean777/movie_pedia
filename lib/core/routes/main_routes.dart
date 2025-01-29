import 'package:flutter/material.dart';
import 'package:movie_pedia/presentation/auth/signin_page.dart';
import 'package:movie_pedia/presentation/auth/signup_page.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  '/signup': (context) => SignupPage(),
  '/signin': (context) => SigninPage(),
};
