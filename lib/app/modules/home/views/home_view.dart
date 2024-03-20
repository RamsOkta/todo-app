import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sqflite_food_app/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite_food_app/app/routes/app_pages.dart';
import 'package:sqflite_food_app/app/utils/colors.dart';
import 'package:flutter/services.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/food.png").paddingOnly(right: 10.w),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      showSearch(
                        context: context,
                        delegate: HomeSearchDelegate(controller),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(10),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 18.r,
                            color: Colors.grey[500],
                          ),
                          20.horizontalSpace,
                          Text(
                            "Search",
                            style: TextStyle(fontSize: 12.sp),
                          )
                        ],
                      ).paddingAll(10.r),
                    ),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADD_FOOD);
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          20.verticalSpace,
          Text("Katalog Resep Makanan",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500)),
          10.verticalSpace,
          Flexible(
            child: Obx(() => GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.h,
                    crossAxisCount: 2,
                    childAspectRatio: 0.95,
                  ),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () {
                      Get.toNamed(Routes.DETAIL_FOOD,
                          arguments: controller.foods[index].id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setWidth(10),
                        ),
                        border: Border.all(
                          color: Colors.grey[300]!,
                          width: 1.h,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                ScreenUtil().setWidth(10),
                              ),
                              topRight: Radius.circular(
                                ScreenUtil().setWidth(10),
                              ),
                            ),
                            child: Image.memory(
                              controller
                                  .getImage(controller.foods[index].images)!,
                              height: 100.h,
                              width: 200.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  controller.foods[index].nama!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: Colors.grey[600],
                                        ),
                                        5.horizontalSpace,
                                        Text(
                                          "${controller.foods[index].waktuPembuatan} Menit",
                                          style: TextStyle(
                                            fontSize: ScreenUtil().setSp(12),
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5.r,
                                        vertical: 5.r,
                                      ),
                                      height: 26.h,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.r),
                                        ),
                                        color: getColor(
                                          controller.foods[index].jenis!,
                                        ),
                                      ),
                                      child: Text(
                                        "${controller.foods[index].jenis}",
                                        style: TextStyle(
                                          fontSize: 9.sp,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                15.verticalSpace,
                              ],
                            ).paddingOnly(top: 10.h, left: 10.w, right: 10.w),
                          ),
                        ],
                      ),
                    ),
                  ),
                  itemCount: controller.foods.length,
                )),
          ),
        ],
      ).paddingOnly(left: 20.w, right: 20.w, bottom: 20.h),
    );
  }
}

class HomeSearchDelegate extends SearchDelegate<String> {
  final HomeController controller;

  HomeSearchDelegate(this.controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, '');
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
