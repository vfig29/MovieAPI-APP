import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'StorageAdapter.dart';

class SQLAdapter extends StorageAdapter {
  static Database _database;

  Future<Database> get database async {
    _database = (_database ?? await initDB());

    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'movie_database.db');
    String onCreateQuery = 'CREATE TABLE FavMovies (id INTEGER PRIMARY KEY )';

    return await openDatabase(path,
        onCreate: (db, version) => db.execute(onCreateQuery), version: 1);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllMovieFav() async {
    final Database db = await database;
    var results = db.rawQuery('SELECT * FROM FavMovies');
    return results;
  }

  @override
  void removeMovieFav(int movieId) async {
    final Database db = await database;
    String sqlQuery = 'DELETE FROM FavMovies WHERE id = ?';
    var args = [movieId];
    await db.rawDelete(sqlQuery, args);
  }

  @override
  void storeMovieFav(int movieId) async {
    final Database db = await database;
    String sqlQuery = 'INSERT INTO FavMovies(id) VALUES(?)';
    var values = [movieId];
    await db.rawInsert(sqlQuery, values);
  }

  @override
  Future<List<Map<String, dynamic>>> getMovieFavById(int movieId) async {
    final Database db = await database;
    var args = [movieId];
    var results = db.rawQuery('SELECT * FROM FavMovies WHERE id = ?', args);
    return results;
  }
}
