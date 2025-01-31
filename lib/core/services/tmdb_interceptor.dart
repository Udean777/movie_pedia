import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'dart:developer' as developer;

class TMDBInterceptor {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static String apiKey = dotenv.env['TMDB_API_KEY']!;

  static Dio createDio() {
    // developer.log('TMDB_API_KEY: $apiKey', name: 'TMDBInterceptor');

    Dio dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // developer.log(
        //     'Request[${options.method}] => PATH: ${options.path}, QUERY: ${options.queryParameters}',
        //     name: 'TMDBInterceptor');
        options.queryParameters['api_key'] = apiKey;
        handler.next(options);
      },
      onResponse: (response, handler) {
        // developer.log(
        //     'Response[${response.statusCode}] => DATA: ${response.data}',
        //     name: 'TMDBInterceptor');
        handler.next(response);
      },
      onError: (DioException error, handler) {
        // developer.log(
        //     'Error[${error.response?.statusCode}] => MESSAGE: ${error.message}',
        //     name: 'TMDBInterceptor');
        handler.next(error);
      },
    ));

    return dio;
  }
}
