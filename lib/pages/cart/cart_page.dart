import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/pages/cart/cart_history_page.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

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
                      onTap: () {
                        Get.to(const CartHistoryPage());
                      },
                      child: const AppIcon(
                        icon: Icons.shopping_cart_outlined,
                        iconColor: Colors.white,
                        backgroundColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
              // the cart is empty or has items condition.
              cartController.getItems.isNotEmpty
                  ? Positioned(
                      top: Dimensions.height20 * 5,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      bottom: 0,
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: ListView.separated(
                          itemCount: cartController.getItems.length,
                          itemBuilder: (context, index) {
                            CartModel cartItem = cartController.getItems[index];
                            return SizedBox(
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
                                        Get.toNamed(RouteHelper.getPopularFood(
                                            popularIndex));
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(cartItem.product);
                                        if (recommendedIndex < 0) {
                                          Get.snackbar('History Message',
                                              'Product review is not available for history products',
                                              backgroundColor:
                                                  AppColors.mainColor,
                                              colorText: Colors.white);
                                        } else {
                                          Get.toNamed(
                                              RouteHelper.getRecommendedFood(
                                                  recommendedIndex));
                                        }
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                    onTap: () {
                                                      cartController.addItem(
                                                          cartItem.product!,
                                                          -1);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.width10,
                                                  ),
                                                  BigText(
                                                    text: cartController
                                                        .getItems[index]
                                                        .quantity
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
                                                      color:
                                                          AppColors.signColor,
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
                    )
                  : const NoDataPage(
                      text: 'Your cart is empty !',
                      imgPath: 'assets/images/empty_cart.png')
            ],
          ),
          bottomNavigationBar: cartController.getItems.isNotEmpty
              ? Container(
                  height: Dimensions.bottomHeightBar,
                  padding: EdgeInsets.only(
                      top: Dimensions.height10,
                      left: Dimensions.width20,
                      right: Dimensions.width20),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                        ),
                        child: Row(
                          children: [
                            BigText(
                                text:
                                    'Total : \$ ${cartController.totalAmount}'),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          cartController.addToCartHistory();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.width20,
                              vertical: Dimensions.height20),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor),
                          child: BigText(
                            text: 'Check out',
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : const SizedBox());
    });
  }
}
