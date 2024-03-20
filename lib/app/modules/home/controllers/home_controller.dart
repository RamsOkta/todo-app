import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:sqflite_food_app/app/data/food_model.dart';
import 'package:sqflite_food_app/app/utils/DbHelper.dart';

class HomeController extends GetxController {
  final DbHelper db = DbHelper();

  final buttonText = ["All", "Makanan", "Kuah", "Minuman"];

  final iconButton = [
    "assets/images/ic_makanan.png",
    "assets/images/ic_makanan.png",
    "assets/images/ic_kuah.png",
    "assets/images/ic_minuman.png"
  ];

  final selectedValueIndex = 0.obs;

  List<Food> foods = <Food>[].obs;

  Uint8List getImage(String base64String) {
    return db.dataFromBase64String(base64String);
  }

  Future<List<Food>> readRecipe(String jenis) async {
    foods.clear();
    if (jenis != "All") {
      foods.addAll(await db.GetFoodByJenis(jenis));
    } else {
      foods.addAll(await db.queryAllRows());
    }
    return foods;
  }

  @override
  void onInit() {
    super.onInit();
    readRecipe("All");
  }
}
