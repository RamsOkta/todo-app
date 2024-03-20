import 'package:get/get.dart';

import 'package:sqflite_food_app/app/modules/detail_food/bindings/detail_food_binding.dart';
import 'package:sqflite_food_app/app/modules/detail_food/views/detail_food_view.dart';
import 'package:sqflite_food_app/app/modules/home/bindings/home_binding.dart';
import 'package:sqflite_food_app/app/modules/home/views/home_view.dart';
import 'package:sqflite_food_app/app/modules/home/bindings/add_food_binding.dart';
import 'package:sqflite_food_app/app/modules/home/views/add_food_view.dart'; // Import AddFoodView

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_FOOD,
      page: () => DetailFoodView(),
      binding: DetailFoodBinding(),
    ),
    GetPage(
      name: _Paths.ADD_FOOD, // Add route for AddFoodView
      page: () => AddFoodView(),
      binding: AddFoodBinding(), // Add the binding if necessary
    ),
  ];
}
