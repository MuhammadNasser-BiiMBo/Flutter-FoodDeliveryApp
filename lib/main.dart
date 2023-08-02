import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart'as dependencies;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencies.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle( SystemUiOverlayStyle(
      statusBarColor: Colors.transparent.withOpacity(0.1), // Set the status bar color
      statusBarBrightness: Brightness.light, // Set the status bar brightness
      statusBarIconBrightness: Brightness.dark, // Set the status bar icon brightness
    ));
    Get.find<CartController>().getCartData();
    // Get.find<AuthController>().authRepo.apiClient.token=Get.find<AuthController>().authRepo.getUserToken();
    return GetBuilder<PopularProductController>(
      builder:(_)=> GetBuilder<RecommendedProductController>(
        builder:(_)=> GetMaterialApp(
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.mainColor
          ),
        ),
      ),
    );
  }
}
