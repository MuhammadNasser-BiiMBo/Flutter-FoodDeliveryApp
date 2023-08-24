import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/dimensions.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';
import 'food_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    if (Get.find<AuthController>().userLoggedIn()) {
      Get.find<UserController>()
          .getUserInfo()
          .then((value) => Get.find<LocationController>().getUserAddress());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        shadowColor: Colors.white,
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2,vertical: Dimensions.height10/3),
            child: InkWell(
              onTap: () {
                Get.toNamed(RouteHelper.getCartPage());
              },
              child: const AppIcon(
                icon: Icons.shopping_cart_outlined,
                iconColor: AppColors.mainColor,
              ),
            ),
          ),
          SizedBox(width: Dimensions.width10,)
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: Dimensions.height20,
          ),
          const Expanded(
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(), child: FoodPageBody()),
          ),
        ],
      ),
    );
  }
}
