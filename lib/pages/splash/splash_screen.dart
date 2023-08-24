import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{
  late Animation<double> animation;
  late AnimationController controller;

  _loadResources()async{
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }
  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2)
    )..forward();
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
    );
    Timer(const Duration(seconds: 3), ()=>Get.offNamed(RouteHelper.getInitial()));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                    'assets/images/logo part 1.png',
                      width: Dimensions.imageWidth,
                  ),
              ),
          ),
          Center(
              child: Image.asset(
                'assets/images/logo part 2.png',
                width: Dimensions.imageWidth,
              ),
          ),
        ],
      ),
    );
  }
}
