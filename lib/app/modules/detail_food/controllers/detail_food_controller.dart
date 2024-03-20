import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite_food_app/app/data/food_model.dart';
import 'package:sqflite_food_app/app/utils/DbHelper.dart';
import 'package:palette_generator/palette_generator.dart';

class DetailFoodController extends GetxController with StateMixin {
  var db = DbHelper();
  var foodId = Get.arguments as int;
  late Food food;
  late Color dominantColor = Colors.white;

  @override
  void onInit() {
    super.onInit();
    getFoodColor();
  }

  Future<void> getFoodColor() async {
    final Uint8List bytes =
        await db.getById(foodId).then((value) => getImage(value.images));
    final imageProvider = MemoryImage(bytes);
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider);
    dominantColor = paletteGenerator.dominantColor?.color ?? Colors.transparent;
    update();
  }

  Future<Food> getFood(int id) async {
    return db.getById(id);
  }

  Future<void> deleteMenu(int id) async {
    await db.deleteFood(id);
  }

  Uint8List getImage(String base64String) {
    return base64Decode(base64String);
  }

  Future<void> updateMenuWithImage(
    int id,
    String nama,
    int waktuPembuatan,
    String deskripsi,
    String jenis,
    File images,
    String resep,
  ) async {
    change(null, status: RxStatus.loading());
    String image = db.base64String(await images.readAsBytes());
    final data = Food(
      id: id,
      nama: nama,
      waktuPembuatan: waktuPembuatan,
      deskripsi: deskripsi,
      jenis: jenis,
      images: image,
      resep: resep,
    );
    db.updateFood(data);
    change(null, status: RxStatus.success());
  }

  Future<void> updateMenu(
    int id,
    String nama,
    int waktuPembuatan,
    String deskripsi,
    String jenis,
    String images,
    String resep,
  ) async {
    change(null, status: RxStatus.loading());
    final data = Food(
      id: id,
      nama: nama,
      deskripsi: deskripsi,
      waktuPembuatan: int.parse(waktuPembuatan.toString()),
      jenis: jenis,
      resep: resep,
      images: images,
    );
    db.updateFood(data);
    change(null, status: RxStatus.success());
  }
}
