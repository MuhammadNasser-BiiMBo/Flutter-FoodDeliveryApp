import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import 'package:food_delivery_app/pages/home/main_food_page.dart';
import 'package:food_delivery_app/pages/splash/splash_screen.dart';
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
    return GetBuilder<PopularProductController>(
      builder:(_)=> GetBuilder<RecommendedProductController>(
        builder:(_)=> GetMaterialApp(
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
