import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sqflite_food_app/app/data/food_model.dart';
import 'package:sqflite_food_app/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite_food_app/app/utils/DbHelper.dart';

class AddFoodController extends GetxController {
  var db = DbHelper();

  final image = XFile("").obs;

  TextEditingController namaController = TextEditingController();
  TextEditingController waktuPembuatanController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController resepController = TextEditingController();

  final selectJenis = [
    "Makanan",
    "Minuman",
    "Kuah",
  ];

  final selectedJenis = "Makanan".obs;

  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    if (gallery) {
      pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
      );
    } else {
      pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );
    }

    if (pickedFile != null) {
      image.value = pickedFile;
    }
  }

  Future<void> saveData(
    File images,
    String nama,
    int waktuPembuatan,
    String deskripsi,
    String jenis,
    String resep,
  ) async {
    Get.bottomSheet(
      Container(
        height: 80,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            CircularProgressIndicator(),
            Text("Loading"),
          ],
        ),
      ),
    );

    String image = db.base64String(await images.readAsBytes());
    final data = Food(
      nama: nama,
      deskripsi: deskripsi,
      waktuPembuatan: int.parse(waktuPembuatan.toString()),
      jenis: jenis,
      resep: resep,
      images: image,
    );

    final HomeController homeController = Get.find<HomeController>();
    homeController.readRecipe(
      homeController.buttonText[homeController.selectedValueIndex.value],
    );

    db.insertFood(data);
    Get.back();
  }
}
