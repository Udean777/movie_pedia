// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_db.dart';

// ignore_for_file: type=lint
class $WishlistMoviesTable extends WishlistMovies
    with TableInfo<$WishlistMoviesTable, WishlistMovie> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistMoviesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _posterPathMeta =
      const VerificationMeta('posterPath');
  @override
  late final GeneratedColumn<String> posterPath = GeneratedColumn<String>(
      'poster_path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _voteAverageMeta =
      const VerificationMeta('voteAverage');
  @override
  late final GeneratedColumn<double> voteAverage = GeneratedColumn<double>(
      'vote_average', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, posterPath, voteAverage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_movies';
  @override
  VerificationContext validateIntegrity(Insertable<WishlistMovie> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('poster_path')) {
      context.handle(
          _posterPathMeta,
          posterPath.isAcceptableOrUnknown(
              data['poster_path']!, _posterPathMeta));
    } else if (isInserting) {
      context.missing(_posterPathMeta);
    }
    if (data.containsKey('vote_average')) {
      context.handle(
          _voteAverageMeta,
          voteAverage.isAcceptableOrUnknown(
              data['vote_average']!, _voteAverageMeta));
    } else if (isInserting) {
      context.missing(_voteAverageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistMovie map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistMovie(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      posterPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}poster_path'])!,
      voteAverage: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}vote_average'])!,
    );
  }

  @override
  $WishlistMoviesTable createAlias(String alias) {
    return $WishlistMoviesTable(attachedDatabase, alias);
  }
}

class WishlistMovie extends DataClass implements Insertable<WishlistMovie> {
  final int id;
  final String title;
  final String posterPath;
  final double voteAverage;
  const WishlistMovie(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.voteAverage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['poster_path'] = Variable<String>(posterPath);
    map['vote_average'] = Variable<double>(voteAverage);
    return map;
  }

  WishlistMoviesCompanion toCompanion(bool nullToAbsent) {
    return WishlistMoviesCompanion(
      id: Value(id),
      title: Value(title),
      posterPath: Value(posterPath),
      voteAverage: Value(voteAverage),
    );
  }

  factory WishlistMovie.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistMovie(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      posterPath: serializer.fromJson<String>(json['posterPath']),
      voteAverage: serializer.fromJson<double>(json['voteAverage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'posterPath': serializer.toJson<String>(posterPath),
      'voteAverage': serializer.toJson<double>(voteAverage),
    };
  }

  WishlistMovie copyWith(
          {int? id, String? title, String? posterPath, double? voteAverage}) =>
      WishlistMovie(
        id: id ?? this.id,
        title: title ?? this.title,
        posterPath: posterPath ?? this.posterPath,
        voteAverage: voteAverage ?? this.voteAverage,
      );
  WishlistMovie copyWithCompanion(WishlistMoviesCompanion data) {
    return WishlistMovie(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      voteAverage:
          data.voteAverage.present ? data.voteAverage.value : this.voteAverage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistMovie(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('posterPath: $posterPath, ')
          ..write('voteAverage: $voteAverage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, posterPath, voteAverage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistMovie &&
          other.id == this.id &&
          other.title == this.title &&
          other.posterPath == this.posterPath &&
          other.voteAverage == this.voteAverage);
}

class WishlistMoviesCompanion extends UpdateCompanion<WishlistMovie> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> posterPath;
  final Value<double> voteAverage;
  const WishlistMoviesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
  });
  WishlistMoviesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String posterPath,
    required double voteAverage,
  })  : title = Value(title),
        posterPath = Value(posterPath),
        voteAverage = Value(voteAverage);
  static Insertable<WishlistMovie> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? posterPath,
    Expression<double>? voteAverage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (posterPath != null) 'poster_path': posterPath,
      if (voteAverage != null) 'vote_average': voteAverage,
    });
  }

  WishlistMoviesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? posterPath,
      Value<double>? voteAverage}) {
    return WishlistMoviesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      voteAverage: voteAverage ?? this.voteAverage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (posterPath.present) {
      map['poster_path'] = Variable<String>(posterPath.value);
    }
    if (voteAverage.present) {
      map['vote_average'] = Variable<double>(voteAverage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistMoviesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('posterPath: $posterPath, ')
          ..write('voteAverage: $voteAverage')
          ..write(')'))
        .toString();
  }
}

abstract class _$WishlistDb extends GeneratedDatabase {
  _$WishlistDb(QueryExecutor e) : super(e);
  $WishlistDbManager get managers => $WishlistDbManager(this);
  late final $WishlistMoviesTable wishlistMovies = $WishlistMoviesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [wishlistMovies];
}

typedef $$WishlistMoviesTableCreateCompanionBuilder = WishlistMoviesCompanion
    Function({
  Value<int> id,
  required String title,
  required String posterPath,
  required double voteAverage,
});
typedef $$WishlistMoviesTableUpdateCompanionBuilder = WishlistMoviesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> posterPath,
  Value<double> voteAverage,
});

class $$WishlistMoviesTableFilterComposer
    extends Composer<_$WishlistDb, $WishlistMoviesTable> {
  $$WishlistMoviesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnFilters(column));
}

class $$WishlistMoviesTableOrderingComposer
    extends Composer<_$WishlistDb, $WishlistMoviesTable> {
  $$WishlistMoviesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => ColumnOrderings(column));
}

class $$WishlistMoviesTableAnnotationComposer
    extends Composer<_$WishlistDb, $WishlistMoviesTable> {
  $$WishlistMoviesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get posterPath => $composableBuilder(
      column: $table.posterPath, builder: (column) => column);

  GeneratedColumn<double> get voteAverage => $composableBuilder(
      column: $table.voteAverage, builder: (column) => column);
}

class $$WishlistMoviesTableTableManager extends RootTableManager<
    _$WishlistDb,
    $WishlistMoviesTable,
    WishlistMovie,
    $$WishlistMoviesTableFilterComposer,
    $$WishlistMoviesTableOrderingComposer,
    $$WishlistMoviesTableAnnotationComposer,
    $$WishlistMoviesTableCreateCompanionBuilder,
    $$WishlistMoviesTableUpdateCompanionBuilder,
    (
      WishlistMovie,
      BaseReferences<_$WishlistDb, $WishlistMoviesTable, WishlistMovie>
    ),
    WishlistMovie,
    PrefetchHooks Function()> {
  $$WishlistMoviesTableTableManager(_$WishlistDb db, $WishlistMoviesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistMoviesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistMoviesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistMoviesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> posterPath = const Value.absent(),
            Value<double> voteAverage = const Value.absent(),
          }) =>
              WishlistMoviesCompanion(
            id: id,
            title: title,
            posterPath: posterPath,
            voteAverage: voteAverage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String posterPath,
            required double voteAverage,
          }) =>
              WishlistMoviesCompanion.insert(
            id: id,
            title: title,
            posterPath: posterPath,
            voteAverage: voteAverage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WishlistMoviesTableProcessedTableManager = ProcessedTableManager<
    _$WishlistDb,
    $WishlistMoviesTable,
    WishlistMovie,
    $$WishlistMoviesTableFilterComposer,
    $$WishlistMoviesTableOrderingComposer,
    $$WishlistMoviesTableAnnotationComposer,
    $$WishlistMoviesTableCreateCompanionBuilder,
    $$WishlistMoviesTableUpdateCompanionBuilder,
    (
      WishlistMovie,
      BaseReferences<_$WishlistDb, $WishlistMoviesTable, WishlistMovie>
    ),
    WishlistMovie,
    PrefetchHooks Function()>;

class $WishlistDbManager {
  final _$WishlistDb _db;
  $WishlistDbManager(this._db);
  $$WishlistMoviesTableTableManager get wishlistMovies =>
      $$WishlistMoviesTableTableManager(_db, _db.wishlistMovies);
}
