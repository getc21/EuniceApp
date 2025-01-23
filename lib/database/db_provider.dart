import 'dart:async';
import 'dart:developer';
import 'package:eunice_app/model/category.dart';
import 'package:eunice_app/model/product.dart';
import 'package:eunice_app/model/supplier.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static final DBProvider _instance = DBProvider._();
  static Database? _database;

  DBProvider._();

  factory DBProvider() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_data.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
  log('Creando tablas en la base de datos...', name: 'DBProvider');

  try {
    await db.execute(''' 
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        price REAL NOT NULL,
        weight REAL,
        dimensions TEXT,
        category_id INTEGER,
        supplier_id INTEGER,
        stock_quantity INTEGER NOT NULL DEFAULT 0
      );
    ''');
    log('Tabla "products" creada con éxito.', name: 'DBProvider');
  } catch (e) {
    log('Error al crear tabla "products": $e', name: 'DBProvider');
  }

  try {
    await db.execute(''' 
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT
      );
    ''');
    log('Tabla "categories" creada con éxito.', name: 'DBProvider');
  } catch (e) {
    log('Error al crear tabla "categories": $e', name: 'DBProvider');
  }

  try {
    await db.execute(''' 
      CREATE TABLE suppliers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        contact_name TEXT,
        contact_email TEXT,
        contact_phone TEXT,
        address TEXT
      );
    ''');
    log('Tabla "suppliers" creada con éxito.', name: 'DBProvider');
  } catch (e) {
    log('Error al crear tabla "suppliers": $e', name: 'DBProvider');
  }

  try {
    await db.execute(''' 
      CREATE TABLE locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT,
        capacity INTEGER NOT NULL
      );
    ''');
    log('Tabla "locations" creada con éxito.', name: 'DBProvider');
  } catch (e) {
    log('Error al crear tabla "locations": $e', name: 'DBProvider');
  }

  try {
    await db.execute(''' 
      CREATE TABLE inventory_movements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER NOT NULL,
        location_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        movement_type TEXT NOT NULL CHECK (movement_type IN ('IN', 'OUT')),
        movement_date TEXT DEFAULT CURRENT_TIMESTAMP,
        FOREIGN KEY (product_id) REFERENCES products (id),
        FOREIGN KEY (location_id) REFERENCES locations (id)
      );
    ''');
    log('Tabla "inventory_movements" creada con éxito.', name: 'DBProvider');
  } catch (e) {
    log('Error al crear tabla "inventory_movements": $e', name: 'DBProvider');
  }

  try {
    await db.execute(''' 
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_name TEXT NOT NULL,
        customer_email TEXT,
        customer_phone TEXT,
        order_date TEXT DEFAULT CURRENT_TIMESTAMP,
        status TEXT NOT NULL CHECK (status IN ('PENDING', 'SHIPPED', 'DELIVERED', 'CANCELLED'))
      );
    ''');
    log('Tabla "orders" creada con éxito.', name: 'DBProvider');
  } catch (e) {
    log('Error al crear tabla "orders": $e', name: 'DBProvider');
  }

  try {
    await db.execute(''' 
      CREATE TABLE order_items (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        price REAL NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      );
    ''');
    log('Tabla "order_items" creada con éxito.', name: 'DBProvider');
  } catch (e) {
    log('Error al crear tabla "order_items": $e', name: 'DBProvider');
  }
}


  Future<int> insertProduct(Product product) async {
    final db = await database;
    return await db.insert(
        'products', product.toMap()); // Cambiado a 'products'
  }

  Future<int> insertCategory(Category category) async {
    final db = await database;
    return await db.insert(
        'categories', category.toMap()); // Cambiado a 'categories'
  }

  Future<int> insertSupplier(Supplier supplier) async {
    final db = await database;
    return await db.insert(
        'suppliers', supplier.toMap()); // Cambiado a 'suppliers'
  }

  Future<void> closeDB() async {
    final db = await database;
    db.close();
  }
}
