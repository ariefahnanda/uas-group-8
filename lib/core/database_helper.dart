import 'package:ecommerce_app/models/favorite_product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  /// [Inisialisasi database SQFLITE]
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  /// [Membuat atau membuka database]
  _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorite_products.db');

    return openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute('''
        CREATE TABLE favorites(
          id INTEGER PRIMARY KEY,
          title TEXT,
          imageUrl TEXT,
          price TEXT
        )
      ''');
    });
  }

  /// [Menambah produk ke dalam favorit]
  Future<void> addFavorite(FavoriteProduct product) async {
    final db = await database;
    await db.insert(
      'favorites',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// [Mengambil semua produk favorit]
  Future<List<FavoriteProduct>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');

    return List.generate(maps.length, (i) {
      return FavoriteProduct.fromMap(maps[i]);
    });
  }

  /// [Menghapus produk dari favorit]
  Future<void> removeFavorite(int id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
