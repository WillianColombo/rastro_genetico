// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RacaDao? _racaDaoInstance;

  AnimalDao? _animalDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Raca` (`id` INTEGER, `nome` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Animal` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `nome` TEXT, `dataNascimento` TEXT, `raca` INTEGER, `numeroMae` INTEGER, `numeroPai` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RacaDao get racaDao {
    return _racaDaoInstance ??= _$RacaDao(database, changeListener);
  }

  @override
  AnimalDao get animalDao {
    return _animalDaoInstance ??= _$AnimalDao(database, changeListener);
  }
}

class _$RacaDao extends RacaDao {
  _$RacaDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _racaInsertionAdapter = InsertionAdapter(database, 'Raca',
            (Raca item) => <String, Object?>{'id': item.id, 'nome': item.nome});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Raca> _racaInsertionAdapter;

  @override
  Future<List<Raca>> findAllRaca() async {
    return _queryAdapter.queryList('SELECT * FROM Raca',
        mapper: (Map<String, Object?> row) =>
            Raca(id: row['id'] as int?, nome: row['nome'] as String?));
  }

  @override
  Future<List<String>> findAllNomeRaca(int id) async {
    return _queryAdapter.queryList('SELECT nome FROM Raca WHERE id = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as String,
        arguments: [id]);
  }

  @override
  Future<Raca?> findRacaById(int id) async {
    return _queryAdapter.query('SELECT * FROM Raca WHERE id = ?1',
        mapper: (Map<String, Object?> row) =>
            Raca(id: row['id'] as int?, nome: row['nome'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertRaca(Raca raca) async {
    await _racaInsertionAdapter.insert(raca, OnConflictStrategy.abort);
  }
}

class _$AnimalDao extends AnimalDao {
  _$AnimalDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _animalInsertionAdapter = InsertionAdapter(
            database,
            'Animal',
            (Animal item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'dataNascimento': item.dataNascimento,
                  'raca': item.raca,
                  'numeroMae': item.numeroMae,
                  'numeroPai': item.numeroPai
                }),
        _animalUpdateAdapter = UpdateAdapter(
            database,
            'Animal',
            ['id'],
            (Animal item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'dataNascimento': item.dataNascimento,
                  'raca': item.raca,
                  'numeroMae': item.numeroMae,
                  'numeroPai': item.numeroPai
                }),
        _animalDeletionAdapter = DeletionAdapter(
            database,
            'Animal',
            ['id'],
            (Animal item) => <String, Object?>{
                  'id': item.id,
                  'nome': item.nome,
                  'dataNascimento': item.dataNascimento,
                  'raca': item.raca,
                  'numeroMae': item.numeroMae,
                  'numeroPai': item.numeroPai
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Animal> _animalInsertionAdapter;

  final UpdateAdapter<Animal> _animalUpdateAdapter;

  final DeletionAdapter<Animal> _animalDeletionAdapter;

  @override
  Future<List<Animal>> findAllAnimal() async {
    return _queryAdapter.queryList('SELECT * FROM animal ORDER BY animal.id',
        mapper: (Map<String, Object?> row) => Animal(
            id: row['id'] as int?,
            nome: row['nome'] as String?,
            dataNascimento: row['dataNascimento'] as String?,
            raca: row['raca'] as int?,
            numeroMae: row['numeroMae'] as int?,
            numeroPai: row['numeroPai'] as int?));
  }

  @override
  Future<Animal?> findAnimalById(int id) async {
    return _queryAdapter.query('SELECT * FROM animal WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Animal(
            id: row['id'] as int?,
            nome: row['nome'] as String?,
            dataNascimento: row['dataNascimento'] as String?,
            raca: row['raca'] as int?,
            numeroMae: row['numeroMae'] as int?,
            numeroPai: row['numeroPai'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<Animal>> findAnimalByRaca(int raca) async {
    return _queryAdapter.queryList('SELECT * FROM animal WHERE raca = ?1',
        mapper: (Map<String, Object?> row) => Animal(
            id: row['id'] as int?,
            nome: row['nome'] as String?,
            dataNascimento: row['dataNascimento'] as String?,
            raca: row['raca'] as int?,
            numeroMae: row['numeroMae'] as int?,
            numeroPai: row['numeroPai'] as int?),
        arguments: [raca]);
  }

  @override
  Future<void> insertAnimal(Animal animal) async {
    await _animalInsertionAdapter.insert(animal, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAnimal(Animal animal) async {
    await _animalUpdateAdapter.update(animal, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAnimal(Animal animal) async {
    await _animalDeletionAdapter.delete(animal);
  }
}
