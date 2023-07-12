import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      return Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: Dimensions.height20 * 2,
              right: Dimensions.width20,
              left: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const AppIcon(
                      icon: Icons.arrow_back,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                    onTap: () {
                      Get.back();
                    },
                  ),
                  SizedBox(
                    width: Dimensions.width20 * 3,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: const AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Dimensions.height20 * 5,
              left: Dimensions.width20,
              right: Dimensions.width20,
              bottom: 0,
              child: Container(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.separated(
                    itemCount: cartController.getItems.length,
                    itemBuilder: (context, index) {
                      CartModel cartItem = cartController.getItems[index];
                      return Container(
                        height: Dimensions.height20 * 5,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            // the image of the item
                            GestureDetector(
                              onTap: () {
                                var popularIndex =
                                    Get.find<PopularProductController>()
                                        .popularProductList
                                        .indexOf(cartItem.product);
                                if (popularIndex >= 0) {
                                  Get.toNamed(
                                      RouteHelper.getPopularFood(popularIndex));
                                } else {
                                  var recommendedIndex =
                                      Get.find<RecommendedProductController>()
                                          .recommendedProductList
                                          .indexOf(cartItem.product);
                                  Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex));
                                }
                              },
                              child: Container(
                                height: Dimensions.height20 * 5,
                                width: Dimensions.width20 * 5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            AppConstants.BASEURL +
                                                AppConstants.UPLOAD_URL +
                                                cartItem.img!),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: AppColors.mainColor),
                              ),
                            ),
                            // the data of the item
                            Expanded(
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.only(
                                    left: Dimensions.width10,
                                    top: Dimensions.height10),
                                height: Dimensions.height20 * 5,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BigText(text: cartItem.name!),
                                    SmallText(text: 'Spicy'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        BigText(
                                            text: '\$ ${cartItem.price}',
                                            color: Colors.redAccent),
                                        Row(
                                          children: [
                                            GestureDetector(
                                              child: const Icon(
                                                Icons.remove,
                                                color: AppColors.signColor,
                                              ),
                                              onTap: () {
                                                cartController.addItem(
                                                    cartItem.product!, -1);
                                              },
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            BigText(
                                              text: cartController
                                                  .getItems[index].quantity
                                                  .toString(),
                                              // text: popularProduct.inCartItems.toString()
                                            ),
                                            SizedBox(
                                              width: Dimensions.width10,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                cartController.addItem(
                                                    cartItem.product!, 1);
                                              },
                                              child: const Icon(
                                                Icons.add,
                                                color: AppColors.signColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    // the space between every two items
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: Dimensions.height15,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
