import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/base/no_data_page.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/popular_product_controller.dart';
import '../../models/cart_model.dart';
import '../../widgets/big_text.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var itemsPerOrder = Get.find<CartController>().itemsPerOrderList();
    var cartHistoryList = Get.find<CartController>().getCartHistoryList();
    var orderTimes = Get.find<CartController>().getOrderTimesList();
    var listCounter = 0;
    //the time widget functionality to change the time format for each item in the list
    Widget timeWidget() {
      DateTime date = DateFormat('yyyy-MM-dd HH:mm:ss')
          .parse(cartHistoryList[listCounter].time!);
      var inputDate = DateTime.parse(date.toString());
      var outFormat = DateFormat('dd/MM/yyyy hh:mm a');
      var out = outFormat.format(inputDate);
      return BigText(text: out);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        centerTitle: true,
        title: Text(
          'Cart History',
          style: TextStyle(fontSize: Dimensions.fontSize26),
        ),
        actions: [
          GetBuilder<PopularProductController>(builder: (popularProduct) {
            return Padding(
              padding: EdgeInsets.only(top: Dimensions.height10/2,right: Dimensions.width10),
              child: GestureDetector(
                onTap: () {
                  if (popularProduct.totalItems > 0) {
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
                    if (popularProduct.totalItems > 0)
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: Dimensions.width20,
                          height: Dimensions.height20,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor,
                              border: Border.all(color: Colors.white, width: 1)),
                          child: Center(
                              child: BigText(
                                  text: popularProduct.totalItems.toString(),
                                  color: Colors.black,
                                  size: 12)),
                        ),
                      )
                  ],
                ),
              ),
            );
          }),
        ],
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
      ),
      body: Column(
        children: [
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
                  child: cartHistoryList.isNotEmpty
                      ? ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            for (int i = 0; i < itemsPerOrder.length; i++)
                              Container(
                                height: Dimensions.height20 * 7,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 2,
                                      color: AppColors.mainColor,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20)),
                                padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width10,
                                ),
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.height10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(
                                              itemsPerOrder[i], (index) {
                                            if (listCounter <
                                                cartHistoryList.length) {
                                              listCounter++;
                                            }
                                            return index <= 2
                                                ? Container(
                                                    height:
                                                        Dimensions.height20 * 4,
                                                    width:
                                                        Dimensions.width20 * 4,
                                                    margin: EdgeInsets.only(
                                                        right:
                                                            Dimensions.width10),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius10),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.cover,
                                                      imageUrl: AppConstants
                                                              .BASE_URL +
                                                          AppConstants
                                                              .UPLOAD_URL +
                                                          cartHistoryList[
                                                                  listCounter -
                                                                      1]
                                                              .img!,
                                                    ))
                                                : const SizedBox();
                                          }),
                                        ),
                                        SizedBox(
                                          height: Dimensions.height20 * 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SmallText(
                                                text: 'Total',
                                                color: AppColors.titleColor,
                                              ),
                                              BigText(
                                                text:
                                                    '${itemsPerOrder[i]} Items',
                                                color: AppColors.titleColor,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Map<int, CartModel>
                                                      moreOrder = {};
                                                  for (int j = 0;
                                                      j <
                                                          cartHistoryList
                                                              .length;
                                                      j++) {
                                                    if (cartHistoryList[j]
                                                            .time ==
                                                        orderTimes[i]) {
                                                      moreOrder.putIfAbsent(
                                                          cartHistoryList[j]
                                                              .id!, () {
                                                        return CartModel.fromJson(
                                                            jsonDecode(jsonEncode(
                                                                cartHistoryList[
                                                                    j])));
                                                      });
                                                    }
                                                  }
                                                  Get.find<CartController>()
                                                      .setItems = moreOrder;
                                                  Get.find<CartController>()
                                                      .addToCartList();
                                                  Get.toNamed(RouteHelper
                                                      .getCartPage());
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          Dimensions.width10 /
                                                              2,
                                                      vertical:
                                                          Dimensions.height10 /
                                                              2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                    .radius10 /
                                                                2),
                                                    border: Border.all(
                                                        width: 1,
                                                        color: AppColors
                                                            .mainColor),
                                                  ),
                                                  child: SmallText(
                                                    text: 'one more',
                                                    color: AppColors.mainColor,
                                                  ),
                                                ),
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
                        )
                      : const NoDataPage(
                          text: "you didn't but anything so far !",
                          imgPath: 'assets/images/empty_box.png')),
            ),
          )
        ],
      ),
    );
  }
}
