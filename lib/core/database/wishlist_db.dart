import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:movie_pedia/core/models/movie_detail_model.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as p;

part 'wishlist_db.g.dart';

@DataClassName('WishlistMovie')
class WishlistMovies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get posterPath => text()();
  RealColumn get voteAverage => real()();
  TextColumn get genreIds => text().withDefault(const Constant(''))();
  IntColumn get runtime => integer().nullable()();
}

@DriftDatabase(tables: [WishlistMovies])
class WishlistDb extends _$WishlistDb {
  WishlistDb() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            // First add the columns with nullable constraint
            final hasGenreIdsColumn = await customSelect(
              "PRAGMA table_info(wishlist_movies);",
              readsFrom: {wishlistMovies},
            ).get().then(
                (rows) => rows.any((row) => row.data['name'] == 'genre_ids'));

            if (!hasGenreIdsColumn) {
              await migrator.addColumn(
                wishlistMovies,
                wishlistMovies.genreIds,
              );
            }
            final hasRuntimeColumn = await customSelect(
              "PRAGMA table_info(wishlist_movies);",
              readsFrom: {wishlistMovies},
            ).get().then(
                (rows) => rows.any((row) => row.data['name'] == 'runtime'));

            if (!hasRuntimeColumn) {
              await migrator.addColumn(wishlistMovies, wishlistMovies.runtime);
            }

            // Create a new table with the desired schema
            await customStatement('''
              CREATE TABLE wishlist_movies_new (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                title TEXT NOT NULL,
                poster_path TEXT NOT NULL,
                vote_average REAL NOT NULL,
                genre_ids TEXT NOT NULL DEFAULT '',
                runtime INTEGER
              );
            ''');

            // Copy the data from the old table to the new table
            await customStatement('''
              INSERT INTO wishlist_movies_new (id, title, poster_path, vote_average, genre_ids, runtime)
              SELECT id, title, poster_path, vote_average, genre_ids, runtime FROM wishlist_movies;
            ''');

            // Drop the old table
            await customStatement('DROP TABLE wishlist_movies;');

            // Rename the new table to the old table's name
            await customStatement(
                'ALTER TABLE wishlist_movies_new RENAME TO wishlist_movies;');
          }
        },
        beforeOpen: (details) async {
          if (details.wasCreated) {
            // Handle any initialization for new databases
          }

          if (details.hadUpgrade) {
            // Verify data consistency after migration
            await transaction(() async {
              // Ensure all rows have a valid genreIds value
              await customStatement(
                  "UPDATE wishlist_movies SET genre_ids = '' WHERE genre_ids IS NULL");
            });
          }
        },
      );

  Future<List<WishlistMovie>> getWishlist() => select(wishlistMovies).get();

  Future<void> addToWishlist(WishlistMoviesCompanion movie) =>
      into(wishlistMovies).insert(movie);

  Future<void> removeFromWishlist(int movieId) =>
      (delete(wishlistMovies)..where((tbl) => tbl.id.equals(movieId))).go();

  Future<void> removeFromWishlistByTitle(String title) =>
      (delete(wishlistMovies)..where((tbl) => tbl.title.equals(title))).go();

  Future<bool> isMovieInWishlist(String title) async {
    final query = await (select(wishlistMovies)
          ..where((tbl) => tbl.title.equals(title)))
        .get();
    return query.isNotEmpty;
  }
}

extension WishlistMovieExtension on WishlistMovie {
  List<int> get genreIdsList =>
      genreIds.split(',').map((e) => int.parse(e)).toList();

  static WishlistMoviesCompanion fromMovieDetail(MovieDetailModel movie) {
    return WishlistMoviesCompanion.insert(
      title: movie.title,
      posterPath: movie.posterPath,
      voteAverage: double.parse(movie.voteAverage.toString()),
      genreIds: Value(movie.genres.map((g) => g.id.toString()).join(',')),
      runtime: Value(movie.runtime),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'wishlist.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
