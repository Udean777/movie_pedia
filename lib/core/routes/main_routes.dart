import 'package:flutter/material.dart';
import 'package:movie_pedia/presentation/auth/signin_page.dart';
import 'package:movie_pedia/presentation/auth/signup_page.dart';
import 'package:movie_pedia/presentation/search/search_page.dart';
import 'package:movie_pedia/presentation/wishlist/wishlist_page.dart';

final Map<String, WidgetBuilder> mainRoutes = {
  '/signup': (context) => SignupPage(),
  '/signin': (context) => SigninPage(),
  '/wishlist': (context) => WishlistPage(),
  '/search': (context) => SearchPage(),
};
