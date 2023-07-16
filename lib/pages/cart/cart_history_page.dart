import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../widgets/big_text.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {

    var itemsPerOrder = Get.find<CartController>().itemsPerOrder();
    var cartItemsPerOrder = Get.find<CartController>().getCartItemsPerOrder();
    var cartHistoryList = Get.find<CartController>().getCartHistoryList();
    var listCounter = 0;
    print(itemsPerOrder);
    print(cartItemsPerOrder);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SafeArea(
            child: Container(
              width: double.maxFinite,
              color: AppColors.mainColor,
              padding: EdgeInsets.symmetric(
                  vertical: Dimensions.height10,
                  horizontal: Dimensions.width15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BigText(text: 'Cart History', color: Colors.white),
                  const AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    iconColor: AppColors.mainColor,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                top: Dimensions.height15,
                left: Dimensions.width20,
                right: Dimensions.width15,
              ),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    for (int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        height: 145,
                        decoration: BoxDecoration(
                          border:Border.all(width: 2,color: AppColors.mainColor,),
                          borderRadius: BorderRadius.circular(Dimensions.radius20)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10,vertical: Dimensions.height10),
                        margin: EdgeInsets.only(bottom: Dimensions.height10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(text: '21/12/2000 10:00 PM'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  // spacing: Dimensions.width10/2,
                                  direction: Axis.horizontal,
                                  children: List.generate(itemsPerOrder[i], (index) {
                                    if (listCounter < cartHistoryList.length) {
                                      listCounter++;
                                    }
                                    return index<=2?Container(
                                      height: Dimensions.height20 * 4,
                                      width: Dimensions.width20 * 4,
                                      margin: EdgeInsets.only(right: Dimensions.width10),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius10),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(AppConstants.BASEURL+AppConstants.UPLOAD_URL + cartHistoryList[listCounter - 1].img!))),
                                    ):const SizedBox();
                                  }),
                                ),
                                SizedBox(
                                  height: 80,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      SmallText(text: 'Total',color: AppColors.titleColor,),
                                      BigText(text: '${itemsPerOrder[i]} Items',color: AppColors.titleColor,),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: Dimensions.width10/2,vertical: Dimensions.height10/2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radius10/2),
                                          border: Border.all(width:1,color: AppColors.mainColor),
                                        ),
                                        child: SmallText(text: 'one more',color: AppColors.mainColor,),
                                      )
                                    ],
                                  ),
                                )

                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
