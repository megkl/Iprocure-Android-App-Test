import 'package:iprocure_app/Models/category_model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io'; //deal with paths and folders
import 'package:path_provider/path_provider.dart';
import 'package:iprocure_app/Models/product_model.dart';

class DatabaseHelper {
  static DatabaseHelper
      _dbHelper; //declare singleton of this class to be initialized only once thoughout the application
  static Database _database;

  //Define database name and columns
  String productTable = 'product_table';
  String colId = 'Id';
  String colProductName = 'ProductName';
  String colProductCode = 'ProductCode';
  String colCategoryName = 'CategoryName';
  String colQuantityTypeName = 'QuantityTypeName';
  String colQuantity = 'Quantity';
  String colManufacturerName = 'ManufacturerName';
  String colDistributorName = 'DistributorName';
  String colVatEnabled = 'VatEnabled';
  String colUnitCost = 'UnitCost';
  String colRetailPrice = 'RetailPrice';
  String colAgentPrice = 'Agentprice';
  String colWholesalePrice = 'WholesalePrice';
  String colProductImage = 'ProductImage';

  DatabaseHelper._createInstance(); //Named constructor to create instance of database helper

  factory DatabaseHelper() {
    if (_dbHelper == null) {
      _dbHelper = DatabaseHelper
          ._createInstance(); //This is to be executed only one, singleton object
    }

    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'product.db';

    // Open/create the database at a given path
    var productsDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return productsDatabase;
  }

//Create database
  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $productTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colProductName TEXT, '
        '$colProductImage TEXT, $colQuantity INTEGER, $colDistributorName TEXT, $colManufacturerName TEXT,'
        '$colProductCode TEXT, $colCategoryName TEXT, $colQuantityTypeName TEXT, $colVatEnabled boolean NOT NULL default 0,$colUnitCost DOUBLE,'
        '$colWholesalePrice DOUBLE, $colRetailPrice DOUBLE, $colAgentPrice DOUBLE)');
  }

  // Fetch Operation: Get all product objects from database
  Future<List<Map<String, dynamic>>> getProductMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $productTable order by $colProductName ASC');
    var result = await db.query(productTable, orderBy: '$colProductName ASC');
    return result;
  }

  // Insert Operation: Insert a product object to database
  Future<int> insertProduct(Product product) async {
    Database db = await this.database;
    var result = await db.insert(productTable, product.toMap());
    return result;
  }

  // Update Operation: Update a product object and save it to database
  Future<int> updateProduct(Product product) async {
    var db = await this.database;
    var result = await db.update(productTable, product.toMap(),
        where: '$colId = ?', whereArgs: [product.id]);
    return result;
  }

  // Delete Operation: Delete a product object from database
  Future<int> deleteProduct(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $productTable WHERE $colId = $id');
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Product List' [ List<Product> ]
  Future<List<Product>> getProductList() async {
    var productMapList =
        await getProductMapList(); // Get 'Map List' from database
    int count =
        productMapList.length; // Count the number of map entries in db table

    List<Product> productList = [];
    // For loop to create a ' Product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      productList.add(Product.fromMap(productMapList[i]));
    }

    return productList;
  }

  // Get number of product objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $productTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

//Categories
  // Get the 'Map List' [ List<Map> ] and convert it to 'Product List' [ List<Product> ]
  Future<List<Product>> getCategoryList(String categoryname) async {
    var categoryMapList =
        await getProductMapList(); // Get 'Map List' from database
    int count =
        categoryMapList.length; // Count the number of map entries in db table

    List<Product> categoryList = [];
    // For loop to create a ' Product List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      categoryList.add(Product.fromMap(categoryMapList[i]));
    }

    return categoryList.where((x) => x.categoryName == categoryname).toList();
  }
}
