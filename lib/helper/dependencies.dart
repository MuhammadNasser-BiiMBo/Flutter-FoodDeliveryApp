import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controllers/auth_controller.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/location_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repository/auth_repo.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/data/repository/location_repo.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/recommended_product_controller.dart';
import '../controllers/user_controller.dart';
import '../data/repository/user_repo.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async{
  final sharedPreferences = await SharedPreferences.getInstance();

  Get.lazyPut(() => sharedPreferences);
  //apiClient
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASEURL,sharedPreferences:Get.find()));
  //repository getting the ApiClient with the name apiClient
  Get.lazyPut(() => AuthRepo(apiClient: Get.find(),sharedPreferences: sharedPreferences));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient:Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));
  Get.lazyPut(() => LocationRepo(sharedPreferences:Get.find(), apiClient: Get.find()));
  //controllers
  Get.lazyPut(() => AuthController(authRepo:Get.find()));
  Get.lazyPut(() => UserController(userRepo:Get.find()));
  Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo:Get.find()));
  Get.lazyPut(() => CartController(cartRepo:Get.find()));
  Get.lazyPut(() => LocationController(locationRepo:Get.find()));

}