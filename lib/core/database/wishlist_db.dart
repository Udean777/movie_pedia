import 'package:drift/drift.dart';
import 'package:drift/native.dart';
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
}

@DriftDatabase(tables: [WishlistMovies])
class WishlistDb extends _$WishlistDb {
  WishlistDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

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

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'wishlist.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
