import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:food_delivery_app/data/repository/cart_repo.dart';
import 'package:food_delivery_app/data/repository/popular_product_repo.dart';
import 'package:get/get.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';

Future<void> init()async{
  //apiClient
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASEURL));
  //repository getting the ApiClient with the name apiClient
  Get.lazyPut(() => PopularProductRepo(apiClient:Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient:Get.find()));
  Get.lazyPut(() => CartRepo(apiClient:Get.find()));
  //controllers
  Get.lazyPut(() => PopularProductController(popularProductRepo:Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo:Get.find()));
  Get.lazyPut(() => CartController(cartRepo:Get.find()));

}