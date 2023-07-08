import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/colors.dart';
import 'package:food_delivery_app/constants/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/food_data_column.dart';
import '../../widgets/big_text.dart';


class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({super.key});

  @override
  Widget build(BuildContext context) {
    print('current height is :${MediaQuery.of(context).size.height}');
    print('current width is :${MediaQuery.of(context).size.width}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.popularFoodImgSize,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage('assets/images/food0.png')),
                ),
              )),
          Positioned(
            top: Dimensions.height45,
            left: Dimensions.width20,
            right: Dimensions.width20,
            child:   Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.arrow_back,iconSize: Dimensions.iconSize20,),
                AppIcon(icon: Icons.shopping_cart_outlined,iconSize: Dimensions.iconSize20,),
              ],
            )
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularFoodImgSize-30,
            child: Container(
              padding: EdgeInsets.only(
                top: Dimensions.height20,
                left: Dimensions.width20,
                right: Dimensions.width20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius30),
                  topRight: Radius.circular(Dimensions.radius30)
                )
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FoodDataColumn(text: 'Chinese Side',size: 26),
                  SizedBox(height: Dimensions.height20,),
                  BigText(text: 'Introduce')
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: EdgeInsets.only(top: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
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
              child:  Row(
                children: [
                  const Icon(Icons.remove,color: AppColors.signColor,),
                   SizedBox(width: Dimensions.width10,),
                  BigText(text: '0'),
                  SizedBox(width: Dimensions.width10,),
                  const Icon(Icons.add,color: AppColors.signColor,),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor
              ),
              child: BigText(text:'\$10 | Add to cart',color: Colors.white, ),
            )
          ],
        ),
      ),
    );
  }
}
