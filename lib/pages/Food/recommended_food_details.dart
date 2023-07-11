import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/constants.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
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
    return  Scaffold(
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
                const AppIcon(icon: Icons.shopping_cart_outlined,backgroundSize: 45,)
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
                fit: BoxFit.fill,
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
                const AppIcon(icon: Icons.remove,backgroundColor: AppColors.mainColor,iconColor: Colors.white,),
                BigText(text: '\$${product.price} X 0',size: 26,),
                const AppIcon(icon: Icons.add,backgroundColor: AppColors.mainColor,iconColor: Colors.white),
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor
                  ),
                  child: BigText(text:'\$29 | Add to cart',color: Colors.white, ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
