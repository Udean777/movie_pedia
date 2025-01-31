import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:movie_pedia/core/routes/main_routes.dart';
import 'package:movie_pedia/core/wrapper/auth_wrapper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_pedia/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie Pedia',
      themeMode: ThemeMode.system,
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.deepBlue,
      ),
      theme: FlexThemeData.light(
        scheme: FlexScheme.deepBlue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: mainRoutes,
      home: AuthWrapper(),
    );
  }
}
