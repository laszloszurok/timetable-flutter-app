import 'dart:io';

import 'package:timetable_app/models/lesson.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timetable_app/utilities/constants.dart' as Constants;

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper; // singleton object

  DataBaseHelper._createInstance();

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  Database _database; // singleton

  get database async {
    if (_database == null) {
      _database = await initalizeDatabase();
    }
    return _database;
  }

  Future<Database> initalizeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + Constants.DATABASE_PATH;
    return await openDatabase(path, version: 1, onCreate: _create);
  }

  _create(Database database, int version) async {
    return await database.execute(Constants.CREATE_TABLE);
  }

  Future<int> insert(Lesson lesson) async {
    Database database = await this.database;
    var results = database.insert(Constants.TABLE_NAME, lesson.toMap());
    return results;
  }

  Future<List<Map<String, dynamic>>> getDatainMaps(String day) async {
    Database database = await this.database;
    return database.query(Constants.TABLE_NAME,
        where: Constants.DAY_COL + " = ? ", whereArgs: [day]);
  }

  Future<List<Lesson>> getModelsFromMapList(String tab) async {
    List<Map<String, dynamic>> mapList = await getDatainMaps(tab);

    List<Lesson> lessonListModel = List();

    for (int i = 0; i < mapList.length; i++) {
      lessonListModel.add(Lesson.fromMap(mapList[i]));
    }

    return lessonListModel;
  }

  Future<List<Map<String, dynamic>>> getAllDatainMaps() async {
    Database database = await this.database;
    return database.query(Constants.TABLE_NAME);
  }

  Future<List<Lesson>> getAllModelsFromMapList() async {
    List<Map<String, dynamic>> mapList = await getAllDatainMaps();

    List<Lesson> lessonListModel = List();

    for (int i = 0; i < mapList.length; i++) {
      lessonListModel.add(Lesson.fromMap(mapList[i]));
    }

    return lessonListModel;
  }

  Future<int> updateItem(Lesson lesson) async {
    Database database = await this.database;
    return database.update(Constants.TABLE_NAME, lesson.toMap(),
        where: Constants.ID_COL + " = ? ", whereArgs: [lesson.id]);
  }

  Future<int> delete(Lesson lesson) async {
    Database database = await this.database;
    return database.delete(Constants.TABLE_NAME,
        where: Constants.ID_COL + " = ? ", whereArgs: [lesson.id]);
  }

  Future<int> truncate() async {
    Database database = await this.database;
    return database.delete(Constants.TABLE_NAME);
  }
}
