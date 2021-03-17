import 'package:SpaceX_Launcher/helpers/constants.dart';
import 'package:SpaceX_Launcher/model/launches.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'launches.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE launches(id TEXT PRIMARY KEY, isFavorite INT, rocketName TEXT, timeInUnix INT, dateUtc TEXT, formattedDate TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static void addData(Launch launch) async {
    DBHelper.insert(Constants.dbName, {
      'id': launch.id,
      'isFavorite': (launch.isFavorite == true) ? 1 : 0,
      'rocketName': launch.name,
      'timeInUnix': launch.dateUnix,
      'dateUtc': launch.dateUtc.toIso8601String(),
      'formattedDate': DateFormat('dd/MM/yyyy').format(launch.dateUtc)
    });
  }

  static Future<void> toggleFavorite(Launch launch) async {
    final db = await DBHelper.database();
    await db.update(
        Constants.dbName,
        {
          'isFavorite': (launch.isFavorite == true) ? 0 : 1,
        },
        where: 'id = ?',
        whereArgs: [launch.id]);
  }

  static Future<List<Launch>> getLaunches() async {
    final datalist = await DBHelper.getData(Constants.dbName);
    var launches = datalist.map((e) {
      bool isFavorite = (e['isFavorite'] == 1) ? true : false;
      return Launch(
          id: e['id'],
          name: e['rocketName'],
          dateUnix: e['timeInUnix'],
          dateUtc: DateTime.parse(e['dateUtc']),
          formattedDate: e['formattedDate'],
          isFavorite: isFavorite);
    }).toList();
    return launches;
  }

  static Future<void> deleteDB() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.deleteDatabase(path.join(dbPath, 'launches.db'));
  }
}
