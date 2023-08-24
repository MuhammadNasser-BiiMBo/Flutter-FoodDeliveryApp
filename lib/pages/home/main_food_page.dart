import 'package:flutter/material.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import '../../constants/colors.dart';
import '../../constants/dimensions.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/popular_product_controller.dart';
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
        title: Text(
          'Food App',
          style: TextStyle(
            color: Colors.white,
            fontSize: Dimensions.fontSize26,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        shadowColor: Colors.white,
        actions: [
          GetBuilder<PopularProductController>(
              builder: (popularProduct){
                return Padding(
                  padding: EdgeInsets.only(top: Dimensions.height10/2,right: Dimensions.width10),
                  child: GestureDetector(
                    onTap: () {
                      if(Get.find<CartController>().totalItems>0) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          iconSize: Dimensions.iconSize20,
                        ),
                        //for the totalItems in the cart if exist
                        if(Get.find<CartController>().totalItems>0)
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: Dimensions.width20,
                              height: Dimensions.height20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: AppColors.mainColor,
                                border: Border.all(color: Colors.white,width: 1)
                              ),
                              child: Center(child: BigText(text: Get.find<CartController>().totalItems.toString(),color: Colors.black,size: 12)),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              }
          ),
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
