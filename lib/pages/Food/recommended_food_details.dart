import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/controllers/cart_controller.dart';
import 'package:food_delivery_app/controllers/popular_product_controller.dart';
import 'package:food_delivery_app/controllers/recommended_product_controller.dart';
import 'package:food_delivery_app/models/products_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text_widget.dart';
import 'package:get/get.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetails({required this.pageId,super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return  GetBuilder<PopularProductController>(
      builder:(controller)=> Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: Dimensions.toolBarHeight,
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: const AppIcon(icon: Icons.clear,backgroundSize: 45),
                    onTap:(){
                      Get.toNamed(RouteHelper.getInitial());
                    } ,
                  ),
                   GestureDetector(
                    onTap: () {
                      if(controller.totalItems>0) {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: Stack(
                      children: [
                        AppIcon(
                          icon: Icons.shopping_cart_outlined,
                          iconSize: Dimensions.iconSize20,backgroundSize: 45,
                        ),
                        //for the totalItems in the cart if exist
                        if(controller.totalItems>0)
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: Dimensions.width20,
                              height: Dimensions.height20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                                color: AppColors.mainColor,
                              ),
                              child: Center(child: BigText(text: controller.totalItems.toString(),color: Colors.white,size: 12)),
                            ),
                          )
                      ],
                    ),
                  )
                ],
              ),
              bottom: PreferredSize(
                preferredSize:  Size.fromHeight(Dimensions.height30),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )
                  ),
                  padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10),
                  width: double.maxFinite,
                  child: Center(child: BigText(text: product.name!,size: 26,)),
                )),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: Dimensions.imgExpandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASEURL+AppConstants.UPLOAD_URL+product.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                    child: ExpandableTextWidget(
                        text: product.description!,
                      lineHeight: 1.5,
                    ) ,
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: Dimensions.height10/2,horizontal: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                      child: const AppIcon(
                        icon: Icons.remove,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                    onTap: (){
                        controller.setQuantity(false);
                    },
                  ),
                  BigText(text: '\$${product.price} X ${controller.inCartItems}',size: 26,),
                  GestureDetector(
                      onTap:(){
                        controller.setQuantity(true);
                      },
                      child: const AppIcon(
                          icon: Icons.add,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                      )
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBar,
              padding: EdgeInsets.symmetric(vertical:Dimensions.height10,horizontal:Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20*2),
                    topRight: Radius.circular(Dimensions.radius20*2),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    child:  const Icon(Icons.favorite,color: AppColors.mainColor,size: 25,),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.addItem(product);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor
                      ),
                      child: BigText(text:'\$${product.price} | Add to cart',color: Colors.white, ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
