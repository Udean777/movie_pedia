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
  static const VerificationMeta _genreIdsMeta =
      const VerificationMeta('genreIds');
  @override
  late final GeneratedColumn<String> genreIds = GeneratedColumn<String>(
      'genre_ids', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant(''));
  static const VerificationMeta _runtimeMeta =
      const VerificationMeta('runtime');
  @override
  late final GeneratedColumn<int> runtime = GeneratedColumn<int>(
      'runtime', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, posterPath, voteAverage, genreIds, runtime];
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
    if (data.containsKey('genre_ids')) {
      context.handle(_genreIdsMeta,
          genreIds.isAcceptableOrUnknown(data['genre_ids']!, _genreIdsMeta));
    }
    if (data.containsKey('runtime')) {
      context.handle(_runtimeMeta,
          runtime.isAcceptableOrUnknown(data['runtime']!, _runtimeMeta));
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
      genreIds: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre_ids'])!,
      runtime: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}runtime']),
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
  final String genreIds;
  final int? runtime;
  const WishlistMovie(
      {required this.id,
      required this.title,
      required this.posterPath,
      required this.voteAverage,
      required this.genreIds,
      this.runtime});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['poster_path'] = Variable<String>(posterPath);
    map['vote_average'] = Variable<double>(voteAverage);
    map['genre_ids'] = Variable<String>(genreIds);
    if (!nullToAbsent || runtime != null) {
      map['runtime'] = Variable<int>(runtime);
    }
    return map;
  }

  WishlistMoviesCompanion toCompanion(bool nullToAbsent) {
    return WishlistMoviesCompanion(
      id: Value(id),
      title: Value(title),
      posterPath: Value(posterPath),
      voteAverage: Value(voteAverage),
      genreIds: Value(genreIds),
      runtime: runtime == null && nullToAbsent
          ? const Value.absent()
          : Value(runtime),
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
      genreIds: serializer.fromJson<String>(json['genreIds']),
      runtime: serializer.fromJson<int?>(json['runtime']),
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
      'genreIds': serializer.toJson<String>(genreIds),
      'runtime': serializer.toJson<int?>(runtime),
    };
  }

  WishlistMovie copyWith(
          {int? id,
          String? title,
          String? posterPath,
          double? voteAverage,
          String? genreIds,
          Value<int?> runtime = const Value.absent()}) =>
      WishlistMovie(
        id: id ?? this.id,
        title: title ?? this.title,
        posterPath: posterPath ?? this.posterPath,
        voteAverage: voteAverage ?? this.voteAverage,
        genreIds: genreIds ?? this.genreIds,
        runtime: runtime.present ? runtime.value : this.runtime,
      );
  WishlistMovie copyWithCompanion(WishlistMoviesCompanion data) {
    return WishlistMovie(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      posterPath:
          data.posterPath.present ? data.posterPath.value : this.posterPath,
      voteAverage:
          data.voteAverage.present ? data.voteAverage.value : this.voteAverage,
      genreIds: data.genreIds.present ? data.genreIds.value : this.genreIds,
      runtime: data.runtime.present ? data.runtime.value : this.runtime,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistMovie(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('posterPath: $posterPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('genreIds: $genreIds, ')
          ..write('runtime: $runtime')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, posterPath, voteAverage, genreIds, runtime);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistMovie &&
          other.id == this.id &&
          other.title == this.title &&
          other.posterPath == this.posterPath &&
          other.voteAverage == this.voteAverage &&
          other.genreIds == this.genreIds &&
          other.runtime == this.runtime);
}

class WishlistMoviesCompanion extends UpdateCompanion<WishlistMovie> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> posterPath;
  final Value<double> voteAverage;
  final Value<String> genreIds;
  final Value<int?> runtime;
  const WishlistMoviesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.posterPath = const Value.absent(),
    this.voteAverage = const Value.absent(),
    this.genreIds = const Value.absent(),
    this.runtime = const Value.absent(),
  });
  WishlistMoviesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String posterPath,
    required double voteAverage,
    this.genreIds = const Value.absent(),
    this.runtime = const Value.absent(),
  })  : title = Value(title),
        posterPath = Value(posterPath),
        voteAverage = Value(voteAverage);
  static Insertable<WishlistMovie> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? posterPath,
    Expression<double>? voteAverage,
    Expression<String>? genreIds,
    Expression<int>? runtime,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (posterPath != null) 'poster_path': posterPath,
      if (voteAverage != null) 'vote_average': voteAverage,
      if (genreIds != null) 'genre_ids': genreIds,
      if (runtime != null) 'runtime': runtime,
    });
  }

  WishlistMoviesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? posterPath,
      Value<double>? voteAverage,
      Value<String>? genreIds,
      Value<int?>? runtime}) {
    return WishlistMoviesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      voteAverage: voteAverage ?? this.voteAverage,
      genreIds: genreIds ?? this.genreIds,
      runtime: runtime ?? this.runtime,
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
    if (genreIds.present) {
      map['genre_ids'] = Variable<String>(genreIds.value);
    }
    if (runtime.present) {
      map['runtime'] = Variable<int>(runtime.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistMoviesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('posterPath: $posterPath, ')
          ..write('voteAverage: $voteAverage, ')
          ..write('genreIds: $genreIds, ')
          ..write('runtime: $runtime')
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
  Value<String> genreIds,
  Value<int?> runtime,
});
typedef $$WishlistMoviesTableUpdateCompanionBuilder = WishlistMoviesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<String> posterPath,
  Value<double> voteAverage,
  Value<String> genreIds,
  Value<int?> runtime,
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

  ColumnFilters<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get runtime => $composableBuilder(
      column: $table.runtime, builder: (column) => ColumnFilters(column));
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

  ColumnOrderings<String> get genreIds => $composableBuilder(
      column: $table.genreIds, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get runtime => $composableBuilder(
      column: $table.runtime, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get genreIds =>
      $composableBuilder(column: $table.genreIds, builder: (column) => column);

  GeneratedColumn<int> get runtime =>
      $composableBuilder(column: $table.runtime, builder: (column) => column);
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
            Value<String> genreIds = const Value.absent(),
            Value<int?> runtime = const Value.absent(),
          }) =>
              WishlistMoviesCompanion(
            id: id,
            title: title,
            posterPath: posterPath,
            voteAverage: voteAverage,
            genreIds: genreIds,
            runtime: runtime,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required String posterPath,
            required double voteAverage,
            Value<String> genreIds = const Value.absent(),
            Value<int?> runtime = const Value.absent(),
          }) =>
              WishlistMoviesCompanion.insert(
            id: id,
            title: title,
            posterPath: posterPath,
            voteAverage: voteAverage,
            genreIds: genreIds,
            runtime: runtime,
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
