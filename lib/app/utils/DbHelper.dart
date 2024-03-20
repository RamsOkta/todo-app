import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_food_app/app/data/food_model.dart';
import 'dart:io';

class DbHelper {
  static const _databaseName = "food.db";
  static const _databaseVersion = 1;

  static const tableName = "food";

  static const columnId = 'id';
  static const columnNama = 'nama';
  static const columnWaktuPembuatan = 'waktuPembuatan';
  static const columnDeskripsi = 'deskripsi';
  static const columnJenis = 'jenis';
  static const columnImages = 'images';
  static const columnResep = 'resep';

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    if (await databaseExists(path)) {
      return openDatabase(path);
    } else {
      ByteData data = await rootBundle.load("assets/food.db");
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes);
      return openDatabase(path);
    }
  }

  Future<void> insertFood(Food food) async {
    final db = await database;
    await db.insert(
      tableName,
      food.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateFood(Food food) async {
    final db = await database;

    await db.update(
      tableName,
      food.toJson(),
      where: '$columnId == ?',
      whereArgs: [food.id],
    );
  }

  Future<List<Food>> queryAllRows() async {
    final db = await database;

    List<Map<String, dynamic>> foods =
        await db.query(tableName, orderBy: "$columnId DESC");
    return List.generate(
      foods.length,
      (index) => Food(
        id: foods[index]['id'],
        nama: foods[index]['nama'],
        waktuPembuatan: foods[index]['waktuPembuatan'],
        deskripsi: foods[index]['deskripsi'],
        jenis: foods[index]['jenis'],
        images: foods[index]['images'],
        resep: foods[index]['resep'],
      ),
    );
  }

  Future<void> deleteFood(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: '$columnId == ?',
      whereArgs: [id],
    );
  }

  Future<List<Food>> GetFoodByJenis(String jenis) async {
    final db = await database;

    List<Map<String, dynamic>> foods = await db.query(
      tableName,
      where: "$columnJenis == ?",
      whereArgs: [jenis],
      orderBy: "$columnId DESC",
    );
    return List.generate(
      foods.length,
      (index) => Food(
        id: foods[index]['id'],
        nama: foods[index]['nama'],
        waktuPembuatan: foods[index]['waktuPembuatan'],
        deskripsi: foods[index]['deskripsi'],
        jenis: foods[index]['jenis'],
        images: foods[index]['images'],
        resep: foods[index]['resep'],
      ),
    );
  }

  Future<Food> getById(int id) async {
    final db = await database;

    List<Map<String, dynamic>> foods = await db.query(
      tableName,
      where: "$columnId == ?",
      whereArgs: [id],
    );
    return Food(
      id: foods[0]['id'],
      nama: foods[0]['nama'],
      waktuPembuatan: foods[0]['waktuPembuatan'],
      deskripsi: foods[0]['deskripsi'],
      jenis: foods[0]['jenis'],
      images: foods[0]['images'],
      resep: foods[0]['resep'],
    );
  }

  Uint8List base64Decode(String base64String) {
    return base64.decode(base64String);
  }

  String base64String(Uint8List data) {
    return base64Encode(data);
  }

  Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }
}
