part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const DETAIL_FOOD = _Paths.DETAIL_FOOD;
  static const ADD_FOOD = _Paths.ADD_FOOD; // Tambahkan konstanta ADD_FOOD di sini
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const DETAIL_FOOD = '/detail-food';
  static const ADD_FOOD = '/add-food'; // Tambahkan path untuk ADD_FOOD di sini
}
