import 'package:get/get.dart';
import 'package:sqflite_food_app/app/modules/home/controllers/add_food_controller.dart';


class AddFoodBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddFoodController());
  }
}
