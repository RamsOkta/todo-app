import 'package:get/get.dart';
import 'package:sqflite_food_app/app/utils/DbHelper.dart';
import 'package:sqflite_food_app/app/modules/home/controllers/home_controller.dart';


class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<DbHelper>(() => DbHelper());
  }
}
