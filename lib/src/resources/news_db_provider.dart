import 'package:news/src/resources/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart';
import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  Database db;
  NewsDbProvider() {
    init();
  }
  void init() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentDirectory.path, 'items4.db');
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database newDb, int version) {
        newDb.execute("""
          CREATE TABLE Items
            (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INT,
              text TEXT,
              url TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER,
              deleted INTEGER,
              score INTEGER,
              title INTEGER,
              descendants INTEGER
            )
        """);
      },
    );
  }

  @override
  Future<List<int>> fetchTopIds() {
    return null;
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      'Items',
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.length > 0) {
      return ItemModel.fromDb(maps.first);
    }
    return null;
  }

  @override
  Future<int> addItem(ItemModel itemModel) {
    return db.insert('Items', itemModel.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<int> clear() {
   return db.delete('Items');
  }

}

final newsDbProvider = NewsDbProvider();
